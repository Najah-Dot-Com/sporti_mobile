import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporti/feature/model/user_data.dart';

import 'localization/localization_service.dart';


class SharedPref {
  static SharedPref instance = SharedPref._();
  SharedPref._();
  factory SharedPref()=> instance;

  final String fcmKey = "fcm";
  final String langKey = "langKey";
  final String userDataKey = "userData";
  final String loginKey = "login";

  static SharedPreferences? _prefs;




  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }

  setFCMToken(String fcmToken) async {
    try {
      _prefs?.setString(fcmKey, fcmToken);
    } catch (e) {
      printError(info:e.toString());
    }
  }

  String getFCMToken() {
    return _prefs!.getString(fcmKey) ?? "";
  }


  Future<void> setAppLang(String lang)async{
    try {
      if (!GetUtils.isNull(lang)) {
        await _prefs?.setString(langKey, langKey);
        LocalizationService().changeLocale(lang);
      }
    } catch (e) {
      printError(info:e.toString());
    }
  }
  Locale? getAppLanguageMain() {

    try {
       var string = _prefs?.getString(langKey);
       if(string != null && string == LocalizationService.langs[LocalizationService.arIndex]){
         return LocalizationService.localeAr;
       }else if(string != null && string == LocalizationService.langs[LocalizationService.arIndex]){
         return LocalizationService.localeEn;
       }else{
         return LocalizationService.localeAr;
       }
    } catch (e) {
      printError(info:e.toString());
      return LocalizationService.localeAr;
    }
  }

  setUserData(String profileData) async {
    try {
      await _prefs?.setString(userDataKey, profileData.toString());
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  UserData getUserData() {
    try {
      var string = _prefs?.getString(userDataKey) ?? "";
      var decode = json.decode(string);
      UserData profileData = UserData.fromJson(decode);
      return profileData;
    } catch (e) {
      Logger().e(e);
      return UserData();
    }
  }

  setUserLogin(bool isUserLogin) async {
    try {
      await _prefs?.setBool(loginKey, isUserLogin);
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  bool getIsUserLogin() {
    try {
      return _prefs?.getBool(loginKey) ?? false;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  //clear
  clear() async{
    _prefs?.remove(userDataKey);
    _prefs?.remove(fcmKey);
  }

}
