import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporti/feature/model/balance_data.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/util/app_shaerd_data.dart';

import 'localization/localization_service.dart';

class SharedPref {
  static SharedPref instance = SharedPref._();

  SharedPref._();

  factory SharedPref() => instance;

  final String fcmKey = "fcm";
  final String langKey = "langKey";
  final String userDataKey = "userData";
  final String userBalanceKey = "userBalanceKey";
  final String loginKey = "login";
  final String termsTitlekey = "login";
  final String termsDetailskey = "login";
  final String policyTitlekey = "login";
  final String policyDetailskey = "login";

  final String userNameKey = "userName";
  final String passwordKey = "password";

  static SharedPreferences? _prefs;

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }
  setPolicyAndTermsString({String? termsTitle,String? termsDetails,String? policyTitle,String? policyDetails}) async {
    try {
      _prefs?.setString(termsTitlekey, termsTitle??"");
      _prefs?.setString(termsDetailskey, termsDetails??"");
      _prefs?.setString(policyTitlekey, policyTitle??"");
      _prefs?.setString(policyDetailskey, policyDetails??"");
    } catch (e) {
      printError(info: e.toString());
    }
  }
  String getFCMToken() {
    return _prefs!.getString(fcmKey) ?? "";
  }
  String getPolicyTitle() {
      return _prefs!.getString(policyTitlekey) ?? "";
    }
  String getPolicyDetails() {
      return _prefs!.getString(policyDetailskey) ?? "";
    }
  String getTermsTitle() {
      return _prefs!.getString(termsTitlekey) ?? "";
    }
  String getTermsDetails() {
      return _prefs!.getString(termsDetailskey) ?? "";
    }
  setFCMToken(String fcmToken) async {
    try {
      _prefs?.setString(fcmKey, fcmToken);
    } catch (e) {
      printError(info: e.toString());
    }
  }

  String getFCMToken() {
    return _prefs!.getString(fcmKey) ?? "";
  }

  Future<void> setAppLang(String lang) async {
    try {
      if (!GetUtils.isNull(lang)) {
        await _prefs?.setString(langKey, lang);
        LocalizationService().changeLocale(lang);
        loginAgain();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Locale? getAppLanguageMain() {
    try {
      var string = _prefs?.getString(langKey);
      if (string != null &&
          string == LocalizationService.langs[LocalizationService.arIndex]) {
        return LocalizationService.localeAr;
      } else if (string != null &&
          string == LocalizationService.langs[LocalizationService.enIndex]) {
        return LocalizationService.localeEn;
      } else {
        return LocalizationService.localeAr;
      }
    } catch (e) {
      printError(info: e.toString());
      return LocalizationService.localeAr;
    }
  }

  setUserBalance(BalanceData value) async {
    try {
      var userData = getUserData();
      userData.balance = value.balance.toString();
      userData.finish = value.finish;
      setUserData(jsonEncode(userData.toJson()));
      await _prefs?.setString(userBalanceKey, jsonEncode(userData.toJson()));
    } catch (e) {
      Logger().e(e);
      return "$e";
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

  setUserName(String userName) async {
    try {
      await _prefs?.setString(userNameKey, userName);
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  String getUserName() {
    try {
      return _prefs?.getString(userNameKey) ?? "";
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  setPassword(String password) async {
    try {
      await _prefs?.setString(passwordKey, password);
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  String getPassword() {
    try {
      return _prefs?.getString(passwordKey) ?? "";
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  //clear
  clear() async {
    _prefs?.remove(userDataKey);
    _prefs?.remove(fcmKey);
  }

  void setUserDataUpdated(json) {
    try {
      var userData = getUserData();
      userData.email = json["email"].toString();
      userData.fullname = json["fullname"].toString();
      userData.picture = json["picture"].toString();
      setUserData(jsonEncode(userData.toJson()));
    } catch (e) {
      Logger().e(e);
    }
  }

  setUserDataVerify() {
    try {
      var userData = getUserData();
      userData.isVerify =true;
      setUserData(jsonEncode(userData.toJson()));
    } catch (e) {
      Logger().e(e);
    }
  }
}
