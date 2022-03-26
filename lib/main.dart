import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sporti/feature/view/views/money_fail/money_fail_view.dart';
import 'package:sporti/util/app_theme.dart';
import 'package:sporti/util/sh_util.dart';

import 'feature/view/views/money_collect/money_collect_view.dart';
import 'feature/view/views/money_gift/money_gift_view.dart';
import 'network/api/dio_manager/dio_manage_class.dart';
import 'util/app_shaerd_data.dart';
import 'util/constance.dart';
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
    return DismissKeyboard(
      child: GetMaterialApp(
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
        home: const MoneyGiftView(),
      ),
    );
  }
}
