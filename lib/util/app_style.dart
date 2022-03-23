import 'package:flutter/material.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';

class AppTextStyle {
  // general style
  static TextStyle _getTextStyle(
      double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        letterSpacing: 0.23,
        fontWeight: fontWeight);
  }

// regular style

  static TextStyle getRegularStyle(
      {double fontSize = AppFontSize.s12, required Color color}) {
    return _getTextStyle(
        fontSize, AppFont.fontFamily, AppFontWeight.regular, color);
  }

// light text style

  static TextStyle getLightStyle(
      {double fontSize = AppFontSize.s12, required Color color}) {
    return _getTextStyle(
        fontSize, AppFont.fontFamily, AppFontWeight.light, color);
  }

// bold text style

  static TextStyle getBoldStyle(
      {double fontSize = AppFontSize.s12, required Color color}) {
    return _getTextStyle(
        fontSize, AppFont.fontFamily, AppFontWeight.bold, color);
  }

// semi bold text style

  static TextStyle getSemiBoldStyle(
      {double fontSize = AppFontSize.s12, required Color color}) {
    return _getTextStyle(
        fontSize, AppFont.fontFamily, AppFontWeight.semiBold, color);
  }

// medium text style

  static TextStyle getMediumStyle(
      {double fontSize = AppFontSize.s12, required Color color}) {
    return _getTextStyle(
        fontSize, AppFont.fontFamily, AppFontWeight.medium, color);
  }
}

class AppBtnStyle {
  static ButtonStyle _getBtnStyle(
    double horizontalPadding,
    Color color,
    double borderRadius,
  ) {
    return ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: horizontalPadding)),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))));
  }

  static ButtonStyle primaryButtonStyle({
    double? horizontalPadding,
    Color? color,
    double? borderRadius,
  }) {
    return _getBtnStyle(horizontalPadding ?? AppPadding.p12,
        color ?? AppColor.primary, AppSize.s6);
  }

  // ButtonStyle? get textButtonStyle => ButtonStyle(
  //     textStyle: MaterialStateProperty.all(textSeconderyButton()),
  //     overlayColor: MaterialStateProperty.all(seconderyColor),
  //     padding:
  //     MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
  //     shape: MaterialStateProperty.all(
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));
  //
  ScrollPhysics? customScrollViewIOS() =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
