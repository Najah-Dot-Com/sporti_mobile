import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/feature/view/views/money_gift/money_gift_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/sh_util.dart';

class MoneyCollectView extends StatelessWidget {
  const MoneyCollectView({Key? key}) : super(key: key);

  Widget get logoPage => SvgPicture.asset(AppMedia.collectMoney);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(elevation: 0,leading: InkWell(onTap: (){Navigator.pop(Get.context!);}, child: Icon(Icons.arrow_back_ios , color: AppColor.black,)),),
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
              textStyle: themeData.textTheme.headline1?.copyWith(color: AppColor.grey),
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
              onClicked: _onGoCommunicationClicked,
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
              txt: /*AppStrings.txtCheckRevenue.tr*/_getMaxBalanceAccount(),
              textStyle: themeData.textTheme.headline1
                  ?.copyWith(color: AppColor.black , fontSize: AppFontSize.s14),
            ),

          ],
        ),
      ),
    );
  }

  void _onGoHomeClicked() {
    Get.to(()=> const HomePageView());
  }

  String _balanceAccount() {
    return AppStrings.txtAccountBalance.tr +
        " ${SharedPref.instance.getUserData().balance} " +
        AppStrings.txtCurrency.tr;
  }
  String _getMaxBalanceAccount() {
    return AppStrings.txtCheckRevenue.tr +
        " ${SharedPref.instance.getAppSettings().maxGift} " +
        AppStrings.txtOrMore.tr;
  }

  void _onGoCommunicationClicked() {
    var currentNum = convertStringToNumber(SharedPref.instance.getUserData().balance?.replaceAll("\$", ""));
    var maxNum = convertStringToNumber(SharedPref.instance.getAppSettings().maxGift?.replaceAll("\$", ""));
   Logger().d("$currentNum  $maxNum");
    if(currentNum >= maxNum) {
      Get.to(()=> const MoneyGiftView());
    }else{
      snackError("", "${_getMaxBalanceAccount()}");
      Logger().d("$currentNum  $maxNum");
    }
  }

  double convertStringToNumber(String? replaceAll) {
    if(replaceAll == null){
      return 0.0;
    }
    return double.tryParse(replaceAll.toString())!.toDouble();
  }
}
