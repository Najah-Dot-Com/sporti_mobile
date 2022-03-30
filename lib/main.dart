import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/util/app_theme.dart';
import 'feature/view/views/auth_resetpassword/auth_resetpassword_view.dart';
import 'feature/view/views/auth_signup/auth_signup_view.dart';
import 'network/api/dio_manager/dio_manage_class.dart';
import 'util/localization/localization_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioManagerClass.getInstance.init();
  runApp(MyApp());
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
    return GetMaterialApp(
      home: const  ResetPasswordView(),//test screens LoginView ResetPasswordView SignupView
      debugShowCheckedModeBanner: false,
      enableLog: true,
      defaultTransition: Transition.native,
      title: 'Sporti',
      locale:LocalizationService.localeEn,
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
    );
  }
}
