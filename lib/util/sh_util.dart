import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static SharedPref instance = SharedPref._();
  SharedPref._();
  factory SharedPref()=> instance;

  final String fcmKey = "fcm";
  final String tokenKey = "token";


  static SharedPreferences? _prefs;




  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }

  setFCMToken(String fcmToken) async {
    try {
      _prefs?.setString("$fcmKey", fcmToken);
    } catch (e) {}
  }

  String getFCMToken() {
    return _prefs!.getString("$fcmKey") ?? "";
  }

  setUserToken(String token) async {
    Logger().i("msg_sett_user_token $token");
    try {
      if (!GetUtils.isNull(token)) {
        _prefs?.setString("$tokenKey", token);
      }
    } catch (e) {}
  }

  getUserToken() {
    try {
      return _prefs?.getString('$tokenKey');
    } catch (e) {
      print(e);
      return "";
    }
  }

  Locale? getAppLanguageMain() {
    return Get.locale;
  }


}
