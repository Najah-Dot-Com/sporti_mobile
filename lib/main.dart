import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huawei_iap/IapClient.dart';
import 'package:huawei_iap/model/PurchaseIntentReq.dart';
import 'package:huawei_iap/model/PurchaseResultInfo.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sporti/fcm/app_fcm.dart';
import 'package:sporti/feature/view/views/auth_splash/auth_splash_view.dart';
import 'package:sporti/network/api/feature/auth_feature.dart';
import 'package:sporti/network/api/feature/subscriptions_feature.dart';
import 'package:sporti/network/api/purchases/purchases_api.dart';
import 'package:sporti/network/firebase/firebase_utils.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_theme.dart';
import 'package:sporti/util/connectivity_widget.dart';
import 'package:sporti/util/sh_util.dart';
import 'feature/viewmodel/privacyPolicy_viewmodel.dart';
import 'network/api/dio_manager/dio_manage_class.dart';
import 'network/api/purchases/hawaii_purchases.dart';
import 'util/app_shaerd_data.dart';
import 'util/localization/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  portraitOrientation();
  await Firebase.initializeApp();
  DioManagerClass.getInstance.init();
  await AppFcm.fcmInstance.init();
  await AppFcm.fcmInstance.getTokenFCM();
  listener();
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp)async{
      await AppFcm.fcmInstance.setupInteractedMessage();
      PrivacyPolicyViewModel _privacyAndTerms =
      Get.put<PrivacyPolicyViewModel>(PrivacyPolicyViewModel());
      await _privacyAndTerms.getPrivacyAndTermsPages();
    });
  if(Platform.isIOS) {
    var hideSocial = await FirebaseRef.instance.isHideSocial();
    await SharedPref.instance.storeSocialHandler(hideSocial);
  }
  /*var adminList =*/ await FirebaseRef.instance.adminList().then((value) async{
     await SharedPref.instance.adminListHandler(value?["admin"]??[]);
  });

  try {
    if (Platform.isAndroid || Platform.isIOS) {
      await PurchasesApi.instance.init() ;
    }else {
      await HawaiiPurchasesApi.instance.init();
    }
  } catch (e) {
    Logger().e(e);
  }
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

void listener() async{
  await AuthFeature.getInstance.getAppSettings();
  if(SharedPref.instance.getIsUserLogin()){
    DateTime subtract = SharedPref.instance.getUserData().expiresIn!.subtract(const Duration(days: 1));
    if(subtract.isAtSameMomentAs(DateTime.now()) ||
        subtract.isAtSameMomentAs(DateTime.now().subtract(const Duration(days: 1)))){
      //here we need refresh token by login again
      loginAgain();
    }
    if(SharedPref.instance.getUserData().plan == null ){
      loginAgain();
    }
    if(SharedPref.instance.getUserData().plan != null && SharedPref.instance.getUserData().plan?.type == null){
      loginAgain();
    }
    //todo this for get subscriptions and store in sp
    SubscriptionsFeature.getInstance.allSubscriptionsPlan();
  }
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
