// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:sporti/util/sh_util.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  // static String baseUrl = "https://sportiapp.com/api/v1";
  static String baseUrl = "https://sportiapp.com/api/v1/";

  ///todo here insert key Of Request
  static String resultKey = "Result";

  //this for login keys
  static String userNameKey = "username";
  static String passwordKey = "password";
  static String fullNameKey = "fullname";
  static String emailKey = "email";
  static String passwordConfirmKey = "password_confirm";
  static String passwordNewKey = "password_new";
  //this for auth keys
  static String Confirm_virify_email_code = 'code';
  //this for account verify keys
  static String userPhoneNumer = 'phone';

  ///todo here insert end Point
  static String loginApi = "login";
  static String signUpApi = "create_account";
  static String logoutApi = "logout";
  static String changePasswordApi = "change_password";
  static String verifyEmailApi = "verifi_email?email=";
  static String confirmEmailApi = "confirm_verifi_email";
  static String verifyAccount = "verifi_account";

  static Map<String, String> header(int typeToken) {
    Map<String, String> headers = {};
    if (typeToken == 0) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
      };
    } else if (typeToken == 1) {
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserData().token}',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    } else if (typeToken == 2) {
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserData().token}',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    } else if (typeToken == 3) {
      headers = {
        //  'Authorization': '${SharedPref.instance.getToken().toString()}',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    } else if (typeToken == 4) {
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserData().token}',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
