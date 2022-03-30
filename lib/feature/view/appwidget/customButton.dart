import 'package:flutter/material.dart';
import 'package:sporti/util/app_style.dart';

import '../../../util/app_color.dart';
import '../../../util/app_font.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String? label;
  final Color? primaryColor;
  final Color? borderColor;
  final Color? labelcolor;
  final Function? onTap;
  bool? isRoundedBorder = true;
  CustomButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.label,
      this.borderColor,
      this.labelcolor,
      this.primaryColor,
      this.onTap,
      required this.isRoundedBorder,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: 
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: isRoundedBorder! ?
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ):RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0)),
              primary: primaryColor, // background
              side: BorderSide(
                  color: borderColor ?? AppColor.primary,
                  width: 0.8) // foreground
              ),
          onPressed: () {
            onTap!();
          },
          child: Text('$label',
              style: AppTextStyle.getSemiBoldStyle(
                color: labelcolor ?? AppColor.white,
                fontSize: AppFontSize.s22,
              )),
        ));
  }
}
