import 'package:flutter/material.dart';
import 'package:sporti/util/app_style.dart';

import '../../../util/app_font.dart';

class SignInButton extends StatelessWidget {
  final double width;
  final double height;
  final String? label;
  final Color? primaryColor;
  final Color? borderColor;
  final Color? labelcolor;
  final Function? onTap;
  const SignInButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.label,
      this.borderColor = Colors.white,
      required this.labelcolor,
      this.primaryColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              primary: primaryColor, // background
              side: BorderSide(color: borderColor!, width: 0.8) // foreground
              ),
          onPressed: () {
            onTap!();
          },
          child: Text('$label',
              style: AppTextStyle.getSemiBoldStyle(
                color: labelcolor!,
                fontSize: AppFontSize.s22,
              )),
        ));
  }
}
