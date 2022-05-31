import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/feature/view/views/auth_resetpassword/auth_resetpassword_view.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/feature/view/views/money_collect/money_collect_view.dart';
import 'package:sporti/feature/viewmodel/firebase_auth_model.dart';
import 'package:sporti/network/api/feature/auth_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/sh_util.dart';
import '../view/views/account_otp/account_otp_view.dart';
import '../view/views/account_success_virefy/account_success_virefy_view.dart';
import '../view/views/auth_forget_otp/auth_otp_view.dart';
import 'package:dio/dio.dart' as multiPart;

class AuthViewModel extends GetxController {
  bool isLoading = false;
  bool isLoadingSkip = false;
  bool isDoneUploadImage = false;
  bool resendCodeLoding = false;
  var acceptPolicy = false;
  final ImagePicker _picker = ImagePicker();
  File? filePath;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  //click on sign in btn on login page
  void signInValid(TextEditingController userNameController,
      TextEditingController passwordController) {
    Map<String, dynamic> map = {
      ConstanceNetwork.userNameKey: userNameController.text.toString(),
      ConstanceNetwork.passwordKey: passwordController.text.toString(),
      ConstanceNetwork.fcmToken: SharedPref.instance.getFCMToken().toString(),
    };
    SharedPref.instance.setUserName(userNameController.text.toString());
    SharedPref.instance.setPassword(passwordController.text.toString());
    _signIn(map);
  }

  //click on sign in btn on login page
  void signInValidSkip(String userNameController,
      String passwordController) {
    Map<String, dynamic> map = {
      ConstanceNetwork.userNameKey: userNameController.toString(),
      ConstanceNetwork.passwordKey: passwordController.toString(),
      ConstanceNetwork.fcmToken: SharedPref.instance.getFCMToken().toString(),
    };
    SharedPref.instance.setUserName(userNameController.toString());
    SharedPref.instance.setPassword(passwordController.toString());
    _signIn(map , isFromSkip:true);
  }

  goToHomePage() async {
    isLoading = true;
    update();
    await SharedPref.instance.setUserDataVerify();
    await Get.offAll(const HomePageView());
    isLoading = false;
    update();
  }

  //make signIn methode
  Future<void> _signIn(Map<String, dynamic> map, {bool? isFromSkip = false}) async {
    try {
      if(!isFromSkip!) {
        isLoading = true;
      }else{
        isLoadingSkip = true;
      }
      update();
      await AuthFeature.getInstance.loginUser(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        // Logger().d(value.toJson());
        Logger().d("user token", value.token);
        if (value.token != null) {
          //TODO : if verification and success go to home page
          await SharedPref.instance.setUserLogin(true);
          Get.offAll(const HomePageView());
          isLoading = false;
          isLoadingSkip = false;
          update();
        } else {
          isLoading = false;
          isLoadingSkip = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        isLoading = false;
        isLoadingSkip = false;
        snackError("", onError.toString());
        Logger().d(onError.toString());
        // isLoading = false;
        update();
      });
    } catch (e) {
      snackError("", e.toString());
      Logger().d(e.toString());
      isLoading = false;
      isLoadingSkip = false;
      update();
    }
  }

  onAcceptChange() {
    acceptPolicy = !acceptPolicy;
    update();
  }

  //click on sign in btn on login page
  void signUpValid(
    TextEditingController userNameController,
    TextEditingController passwordController,
    TextEditingController passwordConfirmationController,
    TextEditingController fullNameController,
    TextEditingController emailController,
  ) {
    if (passwordController.text != passwordConfirmationController.text) {
      snackError("", AppStrings.errorPasswordMatches.tr);
      return;
    }
    if (!acceptPolicy) {
      snackError("", AppStrings.acceptPolicyConditions.tr);
      return;
    }
    Map<String, dynamic> map = {
      ConstanceNetwork.userNameKey: userNameController.text.toString(),
      ConstanceNetwork.passwordKey: passwordController.text.toString(),
      ConstanceNetwork.passwordConfirmKey:
          passwordConfirmationController.text.toString(),
      ConstanceNetwork.emailKey: emailController.text.toString(),
      ConstanceNetwork.fullNameKey: fullNameController.text.toString(),
    };
    SharedPref.instance.setUserName(userNameController.text.toString());
    SharedPref.instance.setPassword(passwordController.text.toString());
    _signUp(map);
  }

  //make signIn methode
  Future<void> _signUp(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.signUpUser(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.token != null) {
          //if verification and success go to home page
          await SharedPref.instance.setUserLogin(true);
          Get.offAll(const HomePageView());
          isLoading = false;
          update();
        } else {
          snackError("Error", AppStrings.txtConnection.tr);
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("Error", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  Future<void> logoutUser({bool? isFromGuest = false}) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.logoutUser().then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to home page
          await SharedPref.instance.setUserLogin(false);
          Get.offAll(LoginView());
          isLoading = false;
          update();
          await SharedPref.instance.clear();
          if(!isFromGuest!) {
            snackSuccess("", value.message);
          }
        } else {
          isLoading = false;
          update();
          await SharedPref.instance.setUserLogin(false);
          Get.offAll(LoginView());
          await SharedPref.instance.clear();
        }
      }).catchError((onError) {
        //handle error from value
        // snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  void resetPassword(
      TextEditingController oldPassController,
      TextEditingController newPassController,
      TextEditingController repeatPassController) {
    if (newPassController.text != repeatPassController.text) {
      snackError("", AppStrings.errorPasswordMatches.tr);
      return;
    }

    Map<String, dynamic> map = {
      ConstanceNetwork.passwordKey: oldPassController.text.toString(),
      ConstanceNetwork.passwordNewKey: newPassController.text.toString(),
      ConstanceNetwork.passwordConfirmKey: repeatPassController.text.toString(),
    };
    _resetPassword(map);
  }

  Future<void> _resetPassword(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.resetUserPassword(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to home page
          isLoading = false;
          update();
          snackSuccess("", value.message);
        } else {
          snackError("", value.message);
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  void verifyEmail(String emailController) {
    var parameters = emailController;

    _verifyEmail(parameters);
  }

// mam.farra2030@gmail.com
  Future<void> _verifyEmail(var parameters) async {
    try {
      resendCodeLoding = true;
      isLoading = true;
      update();
      await AuthFeature.getInstance
          .verifyUserEmail(parameters)
          .then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to ForgetOtpView page
          resendCodeLoding = false;
          isLoading = false;
          update();
          await snackSuccess("", value.message);
          await Get.to(AuthOTPView(
            email: parameters,
          ));
        } else {
          await snackError("", value.message);
          resendCodeLoding = false;
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        resendCodeLoding = false;
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      resendCodeLoding = false;
      isLoading = false;
      update();
    }
  }

  //click on confirmEmail in btn on auth OTP page
  void confirmEmail(
      {TextEditingController? pinCode,
      TextEditingController? passwordNew,
      TextEditingController? passwordConfirm}) async {
    Map<String, dynamic> map = {
      ConstanceNetwork.code: pinCode?.text.toString() ?? '',
      ConstanceNetwork.passwordNewKey: passwordNew?.text.toString() ?? '',
      ConstanceNetwork.passwordConfirmKey:
          passwordConfirm?.text.toString() ?? '',
    };
    await _confirmEmail(
        map: map,
        pinCode: pinCode,
        newPAss: passwordNew,
        confirmPass: passwordConfirm);
  }

  Future<void> _confirmEmail(
      {Map<String, dynamic>? map,
      var pinCode,
      var newPAss,
      var confirmPass}) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.confirmEmail(map!).then((value) async {
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to ResetPasswordView page
          isLoading = false;
          update();
          await snackSuccess("", value.message);
          //this check for decide which screen to move to.
          if (confirmPass == null) {
            Get.offAll(() => ResetPasswordView(
                  pinCodeController: pinCode,
                ));
          } else {
            Get.offAll(() => LoginView());
          }
        } else {
          await snackError("", value.message);
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  //click on verifyAccount in btn on login page
  void verifyAccount(
      {required var userPhoneNumber, required bool onResendCodeClick}) {
    Map<String, dynamic> map = {
      ConstanceNetwork.userPhoneNumer: userPhoneNumber,
    };
    Logger().d(map);
    _verifyAccount(map, userPhoneNumber, onResendCodeClick);
  }

  Future<void> _verifyAccount(
      Map<String, dynamic> map, var phoneNumber, bool onResendCodeClick) async {
    Logger().d(phoneNumber);
    try {
      resendCodeLoding = true;
      if (!onResendCodeClick) {
        isLoading = true;
      }
      update();
      await FirebaseAuthModel.instance.verifyPhoneNumber(phoneNumber, () async {
        //todo here we will do success case
        resendCodeLoding = false;
        isLoading = false;
        // await snackSuccess("", value.message ?? "");
        update();
        // Get.to(page)
        Logger().d(phoneNumber);
        Get.to(() => AccountOtpView(userPhoneNumer: phoneNumber));
      }, () {
        //todo here we will do fail case
        resendCodeLoding = false;
        isLoading = false;
        update();
      });
      // await AuthFeature.getInstance.verifyAccount(map).then((value) async {
      //   if (value.status) {
      //     // if success go to AccountOtpView page
      //     Logger().d(value.toJson());
      //     resendCodeLoding = false;
      //     isLoading = false;
      //     await snackSuccess("", value.message ?? "");
      //     update();
      //     // Get.to(page)
      //     Logger().d(phoneNumber);
      //     Get.to(() => AccountOtpView(userPhoneNumer: phoneNumber));
      //   }else{
      //     resendCodeLoding = false;
      //     isLoading = false;
      //     await snackError("", value.message ?? "");
      //     update();
      //   }
      // }).catchError((onError) {
      //   //handle error from value
      //   snackError("", onError.toString());
      //   Logger().d(onError.toString());
      //   resendCodeLoding = false;
      //   isLoading = false;
      //   update();
      // });
    } catch (e) {
      Logger().d(e.toString());
      resendCodeLoding = false;
      isLoading = false;
      update();
    }
  }

  //click on confirmEmail in btn on account OTP page
  void confirmAccount({
    TextEditingController? pinCode,
  }) async {
    Map<String, dynamic> map = {
      ConstanceNetwork.code: pinCode?.text.toString() ?? '',
    };
    await _confirmAccount(map);
  }

  Future<void> _confirmAccount(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      Logger().d(map[ConstanceNetwork.code]);
      await FirebaseAuthModel.instance
          .sendCodeToFirebase(
              code: map[ConstanceNetwork.code].toString(),
              onSuccess: () async {
                await AuthFeature.getInstance
                    .activatedAccountFirebaseApi()
                    .then((value) async {
                  if (value.status) {
                    //TODO: if verification and success go to ForgetOtpView page
                    isLoading = false;
                    update();
                    await snackSuccess("", value.message);
                    Get.to(const AccountSuccessVerifyView());
                  } else {
                    await snackError("", value.message);
                    isLoading = false;
                    update();
                  }
                }).catchError((onError) {
                  snackError("", onError.toString());
                  Logger().d(onError.toString());
                  isLoading = false;
                  update();
                });
              },
              onFail: () {
                isLoading = false;
                update();
              })
          .catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
      // await AuthFeature.getInstance.confirmAccount(map).then((value) async {
      //   //handle object from value || [save in sharedPreferences]
      //   Logger().d(value.toJson());
      //   if (value.status) {
      //     //TODO: if verification and success go to ForgetOtpView page
      //     isLoading = false;
      //     update();
      //     await snackSuccess("", value.message);
      //     Get.to(const AccountSuccessVerifyView());
      //   } else {
      //     await snackError("", value.message);
      //     isLoading = false;
      //     update();
      //   }
      // }).catchError((onError) {
      //   //handle error from value
      //   snackError("", onError.toString());
      //   Logger().d(onError.toString());
      //   isLoading = false;
      //   update();
      // });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.deleteUserAccount().then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to home page
          await SharedPref.instance.setUserLogin(false);
          Get.offAll(LoginView());
          isLoading = false;
          update();
          await SharedPref.instance.clear();
          snackSuccess("", value.message);
        } else {
          isLoading = false;
          update();
          await SharedPref.instance.setUserLogin(false);
          Get.offAll(LoginView());
          snackError("", value.message);
          await SharedPref.instance.clear();
        }
      }).catchError((onError) {
        //handle error from value
        // snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  imgFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 25,
        maxWidth: AppSize.s120,
        maxHeight: AppSize.s120);
    if (image != null) {
      filePath = File(image.path);
      update();
    } else {
      return;
    }
  }

  imgFromGallery() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        maxWidth: AppSize.s120,
        maxHeight: AppSize.s120);
    if (image != null) {
      filePath = File(image.path);
      update();
    } else {
      return;
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColor.transparent,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            // ignore: avoid_unnecessary_containers
            child: Container(
              padding: const EdgeInsets.all(AppSize.s28),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s28),
                      topRight: Radius.circular(AppSize.s28))),
              child: Wrap(
                children: <Widget>[
                  const SizedBox(height: AppSize.s28),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: AppSize.s4,
                      width: AppSize.s50,
                      decoration: BoxDecoration(
                          color: AppColor.grey,
                          borderRadius: BorderRadius.circular(AppSize.s4)),
                    ),
                  ),
                  const SizedBox(height: AppSize.s28),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(
                      AppStrings.txtGallery.tr,
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(AppStrings.txtCamera.tr,
                        textAlign: TextAlign.right),
                    onTap: () async {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //click on updateProfile btn on login page
  void updateProfile(
    TextEditingController fullNameController,
    TextEditingController emailController,
  ) {
    Map<String, dynamic> map = {
      ConstanceNetwork.fullNameKey: fullNameController.text.toString(),
      ConstanceNetwork.emailKey: emailController.text.toString(),
      ConstanceNetwork.imageKey: filePath != null
          ? multiPart.MultipartFile.fromFileSync(filePath!.path)
          : "",
    };
    _updateProfile(map);
  }

  //make updateProfile methode
  Future<void> _updateProfile(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      isDoneUploadImage = false;
      update();
      await AuthFeature.getInstance.updateProfile(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //if success go to ProfileView page
          SharedPref.instance
              .setUserDataUpdated(value.toJson()[ConstanceNetwork.resultKey]);
          isLoading = false;
          isDoneUploadImage = true;
          snackSuccess("", value.message);
          update();
        } else {
          isLoading = false;
          isDoneUploadImage = false;
          snackError("", value.message);
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        isDoneUploadImage = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      isDoneUploadImage = false;
      update();
    }
  }

  bool isUpdateBtnEnable(
      TextEditingController userName, TextEditingController email) {
    UserData? userData = SharedPref.instance.getUserData();
    if (filePath != null) {
      return true;
    } else if (email.text.isNotEmpty && userData.email != email.text) {
      return true;
    } else if (userData.fullname != userName.text) {
      return true;
    } else if (filePath != null && userData.fullname != userName.text) {
      return true;
    } else if ((filePath != null &&
        userData.fullname != userName.text &&
        userData.email != email.text)) {
      return true;
    } else {
      return false;
    }
  }

  void requestUserBalance(TextEditingController emailController,
      TextEditingController noteController) async {
    Map<String, dynamic> map = {
      ConstanceNetwork.emailKey: emailController.text.toString(),
      ConstanceNetwork.noteKey: noteController.text.toString(),
    };
    await _requestUserBalance(map);
  }

  Future<void> _requestUserBalance(Map<String, dynamic> map) async {
    isLoading = true;
    update();
    await AuthFeature.getInstance.requestUserBalance(map).then((value) async {
      //handle object from value || [save in sharedPreferences]
      Logger().d(value.toJson());
      if (value.status) {
        isLoading = false;
        snackSuccess("", value.message);
        update();
      } else {
        snackError("", value.message);
        isLoading = false;
        update();
      }
    }).catchError((onError) {
      //handle error from value
      snackError("", onError.toString());
      Logger().d(onError.toString());
      isLoading = false;
      update();
    });
  }
}
