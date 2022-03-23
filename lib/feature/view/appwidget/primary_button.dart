import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/three_size_dot.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_style.dart';

import '../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.textButton,
    required this.isLoading,
    required this.onClicked,
    required this.isExpanded,
    this.colorBtn,
    this.colorText,
    this.width,
    this.height,
  }) : super(key: key);
  final String textButton;
  final Function onClicked;
  final bool isExpanded;
  bool isLoading = false;
  final Color? colorBtn, colorText;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? AppSize.s50,
      child: ElevatedButton(
        style:
            AppBtnStyle.primaryButtonStyle(color: colorBtn ?? AppColor.primary),
        onPressed: !isLoading
            ? () {
                onClicked();
              }
            : () {},
        child: isLoading
            ? const ThreeSizeDot()
            : Text(textButton,
                style: AppTextStyle.getBoldStyle(
                  color: colorText ?? AppColor.white,
                  fontSize: AppFontSize.s16,
                )),
      ),
    );
  }
}
