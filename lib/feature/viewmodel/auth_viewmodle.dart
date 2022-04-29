import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/feature/view/views/auth_resetpassword/auth_resetpassword_view.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/feature/view/views/profile/profile_view.dart';
import 'package:sporti/network/api/feature/auth_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/sh_util.dart';

import '../../network/api/dio_manager/dio_manage_class.dart';
import '../view/views/account_otp/account_otp_view.dart';
import '../view/views/account_success_virefy/account_success_virefy_view.dart';
import '../view/views/auth_forget_otp/auth_otp_view.dart';

class AuthViewModel extends GetxController {
  bool isLoading = false;
  bool resendCodeLoding = false;
  var acceptPolicy = false;
  final ImagePicker _picker = ImagePicker();
  static var qudsImage =
      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fm.facebook.com%2FTogetherSupportGaza%2Fphotos%2Fa.666687263409744%2F1899627393449052%2F&psig=AOvVaw3xzEG1gSguKH370R5wFNy3&ust=1650577847682000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCPCD5OTPo_cCFQAAAAAdAAAAABAD";

  var filePath;

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
      ConstanceNetwork.passwordKey: passwordController.text.toString()
    };
    _signIn(map);
  }

  goToHomePage() async {
    isLoading = true;
    update();
    await Get.offAll(const HomePageView());
    isLoading = false;
    update();
  }

  //make signIn methode
  Future<void> _signIn(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.loginUser(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.token != null) {
          //TODO: if verification and success go to home page
          await SharedPref.instance.setUserLogin(true);
          Get.offAll(const HomePageView());
          isLoading = false;
          update();
        } else {
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
          //TODO: if verification and success go to home page
          await SharedPref.instance.setUserLogin(true);
          Get.offAll(const HomePageView());
          isLoading = false;
          update();
        } else {
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

  Future<void> logoutUser() async {
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
          snackSuccess("", value.message);
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
      update();
      await AuthFeature.getInstance
          .verifyUserEmail(parameters)
          .then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to ForgetOtpView page
          resendCodeLoding = false;
          update();
          await snackSuccess("", value.message);
          await Get.to(AuthOTPView(
            email: parameters,
          ));
        } else {
          resendCodeLoding = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        resendCodeLoding = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      resendCodeLoding = false;
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
  void verifyAccount({@required var userPhoneNumber}) {
    Map<String, dynamic> map = {
      ConstanceNetwork.userPhoneNumer: userPhoneNumber,
    };
    Logger().d(map);
    _verifyAccount(map, userPhoneNumber);
  }

  Future<void> _verifyAccount(Map<String, dynamic> map, var phoneNumber) async {
    Logger().d(phoneNumber);
    try {
      resendCodeLoding = true;
      update();
      await AuthFeature.getInstance.verifyAccount(map).then((value) async {
        if (value.status) {
          // if success go to AccountOtpView page
          Logger().d(value.toJson());
          resendCodeLoding = false;
          await snackSuccess("", value.message ?? "");
          update();
          // Get.to(page)
          Logger().d(phoneNumber);
          Get.to(() => AccountOtpView(userPhoneNumer: phoneNumber));
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        resendCodeLoding = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      resendCodeLoding = false;
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
      await AuthFeature.getInstance.confirmAccount(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to ForgetOtpView page
          isLoading = false;
          update();
          await snackSuccess("", value.message);
          Get.to(const AccountSuccessVerifyView());
        } else {
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
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 40);
    if (image != null) {
      // EasyLoading.show(status: '... جاري التحميل'); // show loding indicator
      filePath = File(image.path);
      update();
      // EasyLoading.dismiss(); // stop loging indicator
    } else {
      return;
    }
  }

  imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (image != null) {
      filePath = File(image.path);
      update();
    } else {
      return;
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(
                      AppStrings.txtGallery.tr,
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      await imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(AppStrings.txtCamera.tr,
                        textAlign: TextAlign.right),
                    onTap: () async {
                      await imgFromCamera();
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
      ConstanceNetwork.image:
          DioManagerClass.getInstance.uploadImage(file: filePath),
    };
    Logger().i('filePath : $filePath');
    _updateProfile(map);
  }

  //make updateProfile methode
  Future<void> _updateProfile(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.updateProfile(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status == 200) {
          //if success go to ProfileView page
          Get.offAll(const ProfileView());
          isLoading = false;
          update();
        } else {
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

  // void getImage(ImageSource imageSource) async {
  //   final ImagePicker _picker = ImagePicker();
  //   PickedFile imageFile = await _picker.getImage(source: imageSource);
  //   if (imageFile == null) return;
  //   File tmpFile = File(imageFile.path);
  //   tmpFile = await tmpFile.copy(tmpFile.path);
  // }
}
