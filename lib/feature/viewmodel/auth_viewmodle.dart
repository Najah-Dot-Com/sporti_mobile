import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/network/api/feature/auth_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/sh_util.dart';

class AuthViewModel extends GetxController{
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

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
          Get.offAll( const HomePageView());
          // if (value.verified!) {
          //   Get.offAll( const HomePageView());
          // } else {
          //    snackError("", txtNotConfirmEmail.toString());
          // }
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

}