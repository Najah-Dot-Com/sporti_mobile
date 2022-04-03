import 'package:get/get.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String baseUrl = "https://sportiapp.com/api/";

  ///todo here insert key Of Request
  static String  resultKey = "Result";

  //this for login keys
  static String userNameKey = "username";
  static String passwordKey = "password";

  ///todo here insert end Point
  static String loginApi = "login";





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
        'Content-Type': 'application/x-www-form-urlencoded',
        'Language': Get.locale.toString().split("_")[0],
      };
    } else if (typeToken == 2) {
      headers = {
        //    'Authorization': '${SharedPref.instance.getToken().toString()}',
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
        'Authorization': 'Bearer {SharedPref.instance.getUserToken()}',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
