import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_color.dart';
import '../../../util/app_font.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

// ignore: must_be_immutable
class TermsAndPrivacyCheckBox extends StatelessWidget {
  bool? acceptPolicy = false;
  dynamic getColor;
  Function? onTap;
  Function? onChange;
  TermsAndPrivacyCheckBox(
      {Key? key,
      @required this.acceptPolicy,
      @required this.getColor,
      @required this.onTap,
      @required this.onChange,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () {
              onTap;
            },
            child: Text(AppStrings.privacyAndTerms.tr,
                style: AppTextStyle.getMediumStyle(
                    color: AppColor.primary, fontSize: AppFontSize.s20))),
        const SizedBox(
          width: 5,
        ),
         Text(AppStrings.iAccept.tr,
            style: TextStyle(color:AppColor.black, fontSize: 14)),
        Checkbox(
            fillColor: MaterialStateProperty.resolveWith(getColor),
            checkColor: AppColor.white,
            value: acceptPolicy,
            onChanged: (value) {
              onChange;
              // ignore: todo
              //TODO :need for state
              // setState(() {
              //   acceptPolicy = value!;
              // });
            }),
      ],
    );
  }
}
