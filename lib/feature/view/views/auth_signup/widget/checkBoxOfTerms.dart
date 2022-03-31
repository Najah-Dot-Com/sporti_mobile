import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/app_color.dart';
import '../../../../../util/app_font.dart';
import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../appwidget/custome_text_view.dart';

// ignore: must_be_immutable
class TermsAndPrivacyCheckBox extends StatelessWidget {
  bool? acceptPolicy = false;
  dynamic getColor;
  Function? onTap;
  Function? onChange;
  TermsAndPrivacyCheckBox({
    Key? key,
    @required this.acceptPolicy,
    @required this.getColor,
    @required this.onTap,
    @required this.onChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              onTap;
            },
            child: 
            CustomTextView(
            txt: AppStrings.privacyAndTerms.tr,
            textStyle:
                themeData.textTheme.headline6?.copyWith(color: AppColor.primary),
          ),
          ),
        const SizedBox(
          width: 5,
        ),
        CustomTextView(
          txt: AppStrings.iAccept.tr,
          textStyle:
              themeData.textTheme.labelLarge?.copyWith(color: AppColor.black),
        ),
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
