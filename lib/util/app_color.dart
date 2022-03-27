import 'package:flutter/material.dart';

class AppColor {
  static Color primary = HexColor.fromHex("#26C3AE");//gran
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B326C3AE");

  // new colors
  static Color darkPrimary = HexColor.fromHex("#26C3AE");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34"); // red color
  static Color transparent = Colors.transparent;
  static Color black = HexColor.fromHex("#000000");
  static Color scaffold = HexColor.fromHex("#E9F0F1");
}

extension HexColor on Color {
  static fromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
