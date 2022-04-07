import 'package:flutter/material.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

import '../custome_text_view.dart';
import '../primary_button.dart';
import 'package:get/get.dart';

class GlobalBottomSheet extends StatelessWidget {
  const GlobalBottomSheet(
      {Key? key,
      this.title,
      this.subTitle,
      this.isTwoBtn = true,
      this.isLoading = false,
      this.onOkBtnClick,
      this.onCancelBtnClick})
      : super(key: key);
  final String? title, subTitle;
  final bool? isTwoBtn , isLoading;
  final Function()? onOkBtnClick, onCancelBtnClick;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      // height: sizeH300,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(AppSize.s20))),
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSize.s28),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: AppSize.s4,
              width: AppSize.s50,
              decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(AppSize.s4)),
            ),
          ),
          if (title.toString().isNotEmpty) ...[
            const SizedBox(height: AppSize.s28),
            CustomTextView(
              txt: "$title",
              textAlign: TextAlign.center,
              textStyle: themeData.textTheme.headline2,
            ),
          ],
          if (subTitle.toString().isNotEmpty && subTitle != null) ...[
            const SizedBox(height: AppSize.s28),
            CustomTextView(
              txt: "$subTitle",
              textStyle: themeData.textTheme.headline2,
            ),
          ],
          const SizedBox(height: AppSize.s28),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  isLoading: isLoading!,
                  textButton: AppStrings.txtOk.tr,
                  colorText: AppColor.white,
                  colorBtn: AppColor.primary,
                  width: double.infinity,
                  onClicked: onOkBtnClick ?? () {},
                ),
              ),
              const SizedBox(
                width: AppSize.s18,
              ),
              !isTwoBtn!
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: PrimaryButton(
                        isLoading: false,
                        textButton: AppStrings.txtCancel.tr,
                        width: double.infinity,
                        onClicked: onCancelBtnClick ?? () {},
                        colorBtn: AppColor.grey1.withOpacity(0.3),
                        colorText: AppColor.black,
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: AppSize.s30,
          )
        ],
      ),
    );
  }
}
