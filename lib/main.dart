import 'dart:io';

import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sporti/fcm/app_fcm.dart';
import 'package:sporti/feature/view/views/auth_splash/auth_splash_view.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_theme.dart';
import 'package:sporti/util/sh_util.dart';
import 'network/api/dio_manager/dio_manage_class.dart';
import 'util/app_shaerd_data.dart';
import 'util/localization/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  portraitOrientation();
  await Firebase.initializeApp();
  await AppFcm.fcmInstance.init();
  await AppFcm.fcmInstance.getTokenFCM();
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp)async{
      await AppFcm.fcmInstance.setupInteractedMessage();
    });
  HttpOverrides.global = MyHttpOverrides();
  DioManagerClass.getInstance.init();
  runApp(MyApp());
}

// to do this for handShaking Certificate ::
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);
  const MyApp._();
  static final MyApp instance = MyApp._();
  factory MyApp() => instance;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // supportedLocales:const [
          //   Locale("ar"),
          //   Locale("en"),
          // ],
          localizationsDelegates: const [
            CountryLocalizations.delegate,
          ],
          enableLog: true,
          defaultTransition: Transition.native,
          title: AppStrings.appTitle.tr,
          locale: SharedPref.instance.getAppLanguageMain(),
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(450, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
              ),
          theme: AppTheme.getApplicationTheme(),
          home: const SplashView() // UpdateProfileView(),//const SplashView(),
          ),
    );
  }
}
