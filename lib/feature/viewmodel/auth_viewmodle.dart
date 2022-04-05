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
          Get.offAll(const LoginView());
          isLoading = false;
          update();
          await SharedPref.instance.clear();
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
          await Get.to(AuthOTPView(email: parameters,)); 
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
  //click on confirmEmail in btn on login page
  void confirmEmail(var pinCode) {
    Map<String, dynamic> map = {
        ConstanceNetwork.Confirm_virify_email_code : pinCode.toString(),
    };
    _confirmEmail(map);
  }
  //make _confirmEmail methode
  Future<void> _confirmEmail(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.confirmEmail(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
          isLoading = false;
          snackSuccess("", value.message);
          update();
        }
      ).catchError((onError) {
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
  //click on confirmEmail in btn on login page
  void verifyAccount({@required var userPhoneNumber}) {
    Map<String, dynamic> map = {
        ConstanceNetwork.userPhoneNumer : userPhoneNumber.toString(),
    };
    _verifyAccount(map);
  }
  //make _confirmEmail methode
  Future<void> _verifyAccount(Map<String, dynamic> map) async {
    try {
      isLoading = true;
      update();
      await AuthFeature.getInstance.confirmEmail(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value.toJson());
          isLoading = false;
          snackSuccess("", value.message);
          update();
        }
      ).catchError((onError) {
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

}
