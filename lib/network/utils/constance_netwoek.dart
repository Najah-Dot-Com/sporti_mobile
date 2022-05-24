// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:sporti/util/sh_util.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String baseUrl = "https://sportiapp.com/api/v1/";
  static String baseImageExercises = "https://sportiapp.com/public/images/exercises/";
  static String baseVideoExercises = "https://sportiapp.com/public/video/exercises/";

  ///todo here insert key Of Request
  static String resultKey = "Result";

  //this for login keys
  static String userNameKey = "username";
  static String passwordKey = "password";
  static String fullNameKey = "fullname";
  static String emailKey = "email";
  static String passwordConfirmKey = "password_confirm";
  static String passwordNewKey = "password_new";
  static String fcmToken = "fcm_token";
  static String notifyType = "notifiy_type";
  static String noteKey = "note";

  //this for auth keys
  static String code = 'code';
  //this for account verify keys
  static String userPhoneNumer = 'phone';
  //this for updateProfile keys
  static String picture = 'picture';
  static String imageKey = "image";

  //this for home page
  static String parentIdKey = "parent_id";
  static String exerciseIdKey = "exercise_id";
  static String typeKey = "type";
  static String typeDoneKey = "done";
  static String typeReturnKey = "return";
  static String returnDateKey = "return_date";
  static String returnTimeKey = "return_time";

  ///todo here insert end Point
  //auth end point
  static String loginApi = "login";
  static String signUpApi = "create_account";
  static String logoutApi = "logout";
  static String deleteUserApi = "delete_account";
  static String changePasswordApi = "change_password";

  //exercises end point
  static String exercisesApi = "exercises";
  static String topExercisesApi = "top_exercises";
  static String isFavoriteApi = "is_favorite";
  static String eventExercisesApi = "event_exercises";
  static String favoriteExercisesApi = "favorite_exercises";
  static String balanceUserApi = "balance_user";
  static String detailsExercisesApi = "details_exercises?seq=";
  static String searchExercisesApi = "search_exercises?q=";

  static String verifyEmailApi = "verifi_email?email=";
  static String confirmEmailApi = "confirm_verifi_email";
  static String verifyAccount = "verifi_account";
  static String confirmAccount = "confirm_verifi_code";
  //profile end point
  static String updateProfile = "update_profile";
  static String balanceRequestApi = "balance_request";

  //Notifications end point
  static String allNotificationse = "get_notification"; //?page=
  //privace and policy  end point
  static String getPages = "get_page";
  static String settingApi = "setting";



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
    } else if (typeToken == 5) {
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserData().token}',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
