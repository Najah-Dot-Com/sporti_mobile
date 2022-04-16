import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/feature/view/views/auth_resetpassword/auth_resetpassword_view.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/network/api/feature/auth_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/sh_util.dart';

import '../view/views/account_otp/account_otp_view.dart';
import '../view/views/account_success_virefy/account_success_virefy_view.dart';
import '../view/views/auth_forget_otp/auth_otp_view.dart';

class AuthViewModel extends GetxController {
  bool isLoading = false;

  var acceptPolicy = false;

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

  void verifyEmail(TextEditingController emailController) {
    var parameters = emailController.text.toString();

    _verifyEmail(parameters);
  }

// mam.farra2030@gmail.com
  Future<void> _verifyEmail(var parameters) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance
          .verifyUserEmail(parameters)
          .then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
        if (value.status) {
          //TODO: if verification and success go to ForgetOtpView page
          isLoading = false;
          update();
          await snackSuccess("", value.message);
          await Get.to(AuthOTPView(
            email: parameters,
          ));
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
            Get.to(() => ResetPasswordView(
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
      isLoading = true;
      update();
      await AuthFeature.getInstance.verifyAccount(map).then((value) async {
        if (value.status) {
          // if success go to AccountOtpView page
          Logger().d(value.toJson());
          isLoading = false;
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
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
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
}
