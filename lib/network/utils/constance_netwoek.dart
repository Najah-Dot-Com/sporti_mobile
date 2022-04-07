import 'package:get/get.dart';
import 'package:sporti/util/sh_util.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String baseUrl = "https://sportiapp.com/api/v1/";

  ///todo here insert key Of Request
  static String  resultKey = "Result";

  //this for login keys
  static String userNameKey = "username";
  static String passwordKey = "password";
  static String fullNameKey = "fullname";
  static String emailKey = "email";
  static String passwordConfirmKey = "password_confirm";
  static String passwordNewKey = "password_new";

  //this for home page
  static String parentIdKey = "parent_id";
  static String exerciseIdKey = "exercise_id";
  static String typeKey = "type";
  static String typeDoneKey = "done";
  static String typeReturnKey = "return";

  ///todo here insert end Point
  //auth end point
  static String loginApi = "login";
  static String signUpApi = "create_account";
  static String logoutApi = "logout";
  static String changePasswordApi = "change_password";

  //exercises end point
  static String exercisesApi = "exercises";
  static String topExercisesApi = "top_exercises";
  static String isFavoriteApi = "is_favorite";
  static String eventExercisesApi = "event_exercises";







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
