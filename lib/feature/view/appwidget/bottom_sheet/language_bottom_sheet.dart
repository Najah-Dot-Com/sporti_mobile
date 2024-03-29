import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/localization/localization_service.dart';
import 'package:sporti/util/sh_util.dart';

import '../primary_button.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    Key? key,
  }) : super(key: key);

//language
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
          const SizedBox(height: AppSize.s20),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: AppSize.s6,
              width: AppSize.s50,
              decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(AppSize.s6)),
            ),
          ),
          // if (title.toString().isNotEmpty) ...[
          //   SizedBox(height: sizeH25),
          //   CustomTextView(
          //     txt: "$title",
          //     textAlign: TextAlign.center,
          //     textStyle: textStyleTitle(),
          //   ),
          // ],
          const SizedBox(height: AppSize.s24),
          CustomTextView(
            txt:AppStrings.chooseLanguage.tr,
            textAlign: TextAlign.center,
            textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.primary),
          ),

          const SizedBox(
            height: AppSize.s28,
          ),
          PrimaryButton(
              isLoading: false,
              isWithBorderColor: false,
              colorBtn: AppColor.white,
              colorText: AppColor.primary,
              textButton: "العربية",
              width: double.infinity,
              onClicked: _onArClick,
              ),
          const SizedBox(
            height: AppSize.s10,
          ),
          PrimaryButton(
              isLoading: false,
            isWithBorderColor: false,
              colorBtn: AppColor.white,
              colorText: AppColor.black,
              textButton: "English",
              width: double.infinity,
              onClicked: _onEnClick,
              ),

          const SizedBox(
            height: AppSize.s40,
          )
        ],
      ),
    );
  }

  _onArClick() {
    SharedPref.instance.setAppLang(LocalizationService.langs[LocalizationService.arIndex]);
    Get.back();
  }

  _onEnClick() {
    SharedPref.instance.setAppLang(LocalizationService.langs[LocalizationService.enIndex]);
    Get.back();
  }
}
