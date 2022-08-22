import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporti/feature/model/balance_data.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/model/settings_data.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/feature/viewmodel/privacyPolicy_viewmodel.dart';
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
  final String termsTitlekey = "termsTitlekey";
  final String termsDetailskey = "termsDetailskey";
  final String policyTitlekey = "policyTitlekey";
  final String policyDetailskey = "policyDetailskey";
  final String isBoardingViewKey = "isBoardingView";
  final String appSettingsKey = "appSettings";
  final String appSubscriptionsKey = "appSubscriptions";
  final String userNameSocialKey = "UserNameSocial";
  final String emailSocialKey = "setEmailSocial";
  final String imageSocialKey = "setImageSocial";
  final String idSocialKey = "setIdSocial";
  final String socialTypeKey = "setSocialType";
  final String adminListKey = "adminList";

  final String userNameKey = "userName";
  final String passwordKey = "password";
  final String socialHandlerKey = "SocialHandler";

  static SharedPreferences? _prefs;

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }

  setPolicyAndTermsString(
      {String? termsTitle,
      String? termsDetails,
      String? policyTitle,
      String? policyDetails}) async {
    try {
      _prefs?.setString(termsTitlekey, termsTitle ?? "");
      _prefs?.setString(termsDetailskey, termsDetails ?? "");
      _prefs?.setString(policyTitlekey, policyTitle ?? "");
      _prefs?.setString(policyDetailskey, policyDetails ?? "");
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

  Future<void> setAppLang(String lang) async {
    try {
      if (!GetUtils.isNull(lang)) {
        await _prefs?.setString(langKey, lang);
        LocalizationService().changeLocale(lang);
        loginAgain();
        Get.put(PrivacyPolicyViewModel()).getPrivacyAndTermsPages();
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
    _prefs?.remove(userNameSocialKey);
    _prefs?.remove(emailSocialKey);
    _prefs?.remove(imageSocialKey);
    _prefs?.remove(idSocialKey);
    _prefs?.remove(socialTypeKey);
    _prefs?.remove(userNameKey);
    _prefs?.remove(passwordKey);

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
      userData.isVerify = true;
      setUserData(jsonEncode(userData.toJson()));
    } catch (e) {
      Logger().e(e);
    }
  }

  void setOnBoardingView(bool isView) {
    try {
       _prefs?.setBool(isBoardingViewKey , isView) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  bool getOnBoardingView() {
    try {
    return  _prefs?.getBool(isBoardingViewKey) ?? false ;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  setAppSettings(String encode) {
    try {
      _prefs?.setString(appSettingsKey , encode) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  SettingData getAppSettings() {
    try {
      var string = _prefs?.getString(appSettingsKey) ?? "";
      var decode = json.decode(string);
      SettingData profileData = SettingData.fromJson(decode);
      return profileData;
    } catch (e) {
      Logger().e(e);
      return SettingData();
    }
  }

  void setAllSubscriptions(String result) {
    try {
      _prefs?.setString(appSubscriptionsKey , result) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  List<PlanData> getAllSubscriptions() {
    try {
      var string = _prefs?.getString(appSubscriptionsKey) ?? "";
      var decode = json.decode(string);
      List result = decode;
      List<PlanData> data = result.map((e) => PlanData.fromJson(e)).toList();
      return data;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  void setUserNameSocial(String fullNameKey) {
    try {
      _prefs?.setString(userNameSocialKey , fullNameKey) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  void setEmailSocial(String emailKey) {

    try {
      _prefs?.setString(emailSocialKey , emailKey) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  void setImageSocial(String imageKey) {

    try {
      _prefs?.setString(imageSocialKey , imageKey) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  void setIdSocial(String socialId) {

    try {
      _prefs?.setString(idSocialKey , socialId) ;
    } catch (e) {
      Logger().e(e);
    }
  }

  void setSocialType(String socialType) {

    try {
      _prefs?.setString(socialTypeKey , socialType) ;
    } catch (e) {
      Logger().e(e);
    }
  }




  String getUserNameSocial() {
    try {
      return _prefs?.getString(userNameSocialKey ) ??"" ;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  String getEmailSocial() {

    try {
      return _prefs?.getString(emailSocialKey ) ??"";
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  String getImageSocial() {

    try {
      return _prefs?.getString(imageSocialKey ) ??"";
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  String getIdSocial() {

    try {
      return _prefs?.getString(idSocialKey) ?? "" ;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  String getSocialType() {

    try {
      return _prefs?.getString(socialTypeKey )??"" ;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  storeSocialHandler(bool isHide){
    _prefs?.setBool(socialHandlerKey, isHide);
  }

  bool getStoreSocialHandler(){
    return  _prefs?.getBool(socialHandlerKey )?? false;
  }

  adminListHandler(var adminList) {
    _prefs?.setString(adminListKey, jsonEncode(adminList));
  }
  List<String> getAdminListHandler() {
    var data = _prefs?.getString(adminListKey);
    var decode = json.decode(data.toString());
    List items = decode;
    List<String> list = items.map((e)=> e.toString()).toList();
    Logger().d(list /*is String*/ );
   return  list;
  }

}
