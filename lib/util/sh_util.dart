import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/localization_service.dart';


class SharedPref {
  static SharedPref instance = SharedPref._();
  SharedPref._();
  factory SharedPref()=> instance;

  final String fcmKey = "fcm";
  final String tokenKey = "token";
  final String langKey = "langKey";


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

  setUserToken(String token) async {
    Logger().i("msg_sett_user_token $token");
    try {
      if (!GetUtils.isNull(token)) {
        _prefs?.setString(tokenKey, token);
      }
    } catch (e) {
      printError(info:e.toString());
    }
  }

  getUserToken() {
    try {
      return _prefs?.getString(tokenKey);
    } catch (e) {
      printError(info:e.toString());
      return "";
    }
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
         return LocalizationService.localeEn;
       }
    } catch (e) {
      printError(info:e.toString());
      return LocalizationService.localeEn;
    }
  }


}
