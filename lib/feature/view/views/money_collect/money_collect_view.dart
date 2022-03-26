import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';

class MoneyCollectView extends StatelessWidget {
  const MoneyCollectView({Key? key}) : super(key: key);

  Widget get logoPage => SvgPicture.asset(AppMedia.collectMoney);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoPage,
            const SizedBox(
              height: AppSize.s65,
            ),
            CustomTextView(
              txt: _balanceAccount(),
              textStyle:
                  themeData.textTheme.headline1?.copyWith(color: AppColor.grey),
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            CustomTextView(
              textAlign: TextAlign.center,
              txt: AppStrings.txtCallRequest.tr,
              textStyle: themeData.textTheme.headline1
                  ?.copyWith(color: AppColor.primary),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            PrimaryButton(
              textButton: AppStrings.txtCommunication.tr,
              isLoading: false,
              onClicked: _onGoHomeClicked,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            PrimaryButton(
              colorBtn: AppColor.white,
              colorText: AppColor.primary,
              textButton: AppStrings.txtHome.tr,
              isLoading: false,
              onClicked: _onGoHomeClicked,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextView(
              textAlign: TextAlign.center,
              txt: AppStrings.txtCheckRevenue.tr,
              textStyle: themeData.textTheme.headline1
                  ?.copyWith(color: AppColor.black , fontSize: AppFontSize.s14),
            ),

          ],
        ),
      ),
    );
  }

  void _onGoHomeClicked() {}

  String _balanceAccount() {
    return AppStrings.txtAccountBalance.tr +
        " 200 " +
        AppStrings.txtCurrency.tr;
  }
}
