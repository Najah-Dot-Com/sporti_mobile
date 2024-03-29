import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_dimen.dart';
import 'app_font.dart';
import 'app_style.dart';

 class AppTheme {
  static ThemeData getApplicationTheme() {
    return ThemeData(
        // main colors of the app
        fontFamily: AppFont.fontFamily,
        primaryColor: AppColor.primary,
        primaryColorLight: AppColor.primaryOpacity70,
        primaryColorDark: AppColor.darkPrimary,
        disabledColor: AppColor.grey1,
        // will be used incase of disabled button for example
        // ripple color
        splashColor: AppColor.primaryOpacity70,
        // accentColor: AppColor.grey,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
        //
        colorScheme: ColorScheme.light(primary: AppColor.primary),//best
        // colorScheme: ColorScheme.fromSwatch(
        //   accentColor: AppColor.grey,
        //   primaryColorDark: AppColor.darkPrimary,
        // ),
        scaffoldBackgroundColor: AppColor.scaffold,
        // card view theme
        cardTheme: CardTheme(
            color: AppColor.white,
            shadowColor: AppColor.grey,
            elevation: AppSize.s4),

        // App bar theme
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: AppColor.white,
            elevation: AppSize.s4,
            shadowColor: AppColor.white,
            titleTextStyle: AppTextStyle.getRegularStyle(
                color: AppColor.white, fontSize: AppFontSize.s16)),
        // Button theme
        buttonTheme: ButtonThemeData(
            shape: const StadiumBorder(),
            disabledColor: AppColor.grey1,
            buttonColor: AppColor.primary,
            splashColor: AppColor.primaryOpacity70),

        // elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: AppTextStyle.getRegularStyle(color: AppColor.white),
                primary: AppColor.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12)))),

        // Text theme
        textTheme: TextTheme(
            headline1: AppTextStyle.getBoldStyle(
                color: AppColor.darkGrey, fontSize: AppFontSize.s21),
            headline2: AppTextStyle.getSemiBoldStyle(
                color: AppColor.darkGrey, fontSize: AppFontSize.s18),
            headline3: AppTextStyle.getSemiBoldStyle(
                color: AppColor.black, fontSize: AppFontSize.s14),
            subtitle1: AppTextStyle.getMediumStyle(
                color: AppColor.lightGrey, fontSize: AppFontSize.s14),
            subtitle2: AppTextStyle.getMediumStyle(
                color: AppColor.primary, fontSize: AppFontSize.s14),
            caption: AppTextStyle.getRegularStyle(color: AppColor.grey1),
            bodyText1: AppTextStyle.getRegularStyle(color: AppColor.grey)),

        // input decoration theme (text form field)

        cursorColor: AppColor.primary,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          // hint style
          hintStyle: AppTextStyle.getRegularStyle(color: AppColor.grey1),

          // label style
          labelStyle: AppTextStyle.getMediumStyle(color: AppColor.darkGrey),
          // error style
          errorStyle: AppTextStyle.getRegularStyle(color: AppColor.error),

          // enabled border
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.grey, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

          // focused border
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

          // error border
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.error, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
          // focused error border
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        ));
  }
}
