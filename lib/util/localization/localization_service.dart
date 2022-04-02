import 'dart:ui';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'lang/ar_su.dart';
import 'lang/en_us.dart';

class LocalizationService extends Translations {
  // Default locale
  static const localeAr =  Locale('ar', 'SA');
  static const localeEn = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');
  // Supported languages
  // Needs to be same order with locales
  static const langs = [
    'Arabic',
    'English',
  ];

  // Supported locales
  // Needs to be same order with langs
  static const locales = [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];

  static var arIndex = 0;
  static var enIndex = 1;



  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    'ar_SA': arSU, // lang/en_us.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}