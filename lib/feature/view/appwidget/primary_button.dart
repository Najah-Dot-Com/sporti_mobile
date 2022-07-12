import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/three_size_dot.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_style.dart';

import '../../../util/app_shaerd_data.dart';
import '../../../util/app_strings.dart';
import 'custome_text_view.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.textButton,
    required this.isLoading,
    required this.onClicked,
    this.colorBtn,
    this.colorText,
    this.width,
    this.height,
    this.isWithBorderColor = true,
  }) : super(key: key);
  final String textButton;
  final Function onClicked;
  bool isLoading = false;
  bool isWithBorderColor = true;
  final Color? colorBtn, colorText;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? AppSize.s60,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s40),
         border: Border.all(color:!isWithBorderColor ? AppColor.transparent: colorText ?? AppColor.white)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s40),
        child: ElevatedButton(
          style: AppBtnStyle.primaryButtonStyle(color: colorBtn ?? AppColor.primary),
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
                    fontSize: AppFontSize.s20,
                  )),
        ),
      ),
    );
  }
}
