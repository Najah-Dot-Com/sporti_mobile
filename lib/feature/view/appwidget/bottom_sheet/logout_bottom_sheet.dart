import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/localization/localization_service.dart';
import 'package:sporti/util/sh_util.dart';

import '../custome_text_view.dart';
import '../primary_button.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({
    Key? key,
  }) : super(key: key);

//language
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (logic) {
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
            const SizedBox(height: AppSize.s24),
            CustomTextView(
              txt: AppStrings.txtLogoutHint.tr,
              textAlign: TextAlign.center,
              textStyle: themeData.textTheme.headline2,
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            PrimaryButton(
              isLoading: logic.isLoading,
              colorBtn: AppColor.error,
              colorText: AppColor.white,
              textButton: AppStrings.txtLogout.tr,
              width: double.infinity,
              onClicked:()=> _onOkClick(logic),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            PrimaryButton(
              isLoading: false,
              colorBtn: AppColor.white,
              colorText: AppColor.black,
              textButton: AppStrings.txtCancel.tr,
              width: double.infinity,
              onClicked: _onCancelClick,
            ),

            const SizedBox(
              height: AppSize.s40,
            )
          ],
        ),
      );
    });
  }

  _onOkClick(AuthViewModel logic)async {
    await logic.logoutUser();
    Get.back();
  }

  _onCancelClick() {
    Get.back();
  }
}
