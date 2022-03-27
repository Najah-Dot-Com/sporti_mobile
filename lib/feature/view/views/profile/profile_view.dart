import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/account_verfiy/account_verfiy_view.dart';
import 'package:sporti/feature/view/views/money_collect/money_collect_view.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/localization/localization_service.dart';
import 'dart:math' as math;

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  static var img =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80";

  Widget _userCardData(ThemeData themeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(AppPadding.p18),
            child: imageNetwork(
                url: img,
                width: AppSize.s120,
                height: AppSize.s120,
                fit: BoxFit.cover)),
        const SizedBox(
          width: AppSize.s20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextView(
              txt: "User name",
              maxLine: Constance.maxLineOne,
              textAlign: TextAlign.start,
              textOverflow:TextOverflow.ellipsis ,
              textStyle: themeData.textTheme.headline2
                  ?.copyWith(fontSize: AppFontSize.s18),),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextView(
              txt: _completedConcatenations(),
              maxLine: Constance.maxLineOne,
              textAlign: TextAlign.start,
              textOverflow:TextOverflow.ellipsis ,
              textStyle: themeData.textTheme.headline2
                  ?.copyWith(fontSize: AppFontSize.s18),),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextView(
              txt: _balanceConcatenations(),
              maxLine: Constance.maxLineOne,
              textAlign: TextAlign.start,
              textOverflow:TextOverflow.ellipsis ,
              textStyle: themeData.textTheme.headline2
                  ?.copyWith(fontSize: AppFontSize.s18),),
          ],
        ),
      ],
    );
  }

  //this for items in the below to go to another pages
  Widget _profileItem(ThemeData themeData , {required Function() onClick,required String title, required String leadingIcon , required String trailingIcon}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: AppSize.s50,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        margin:const EdgeInsets.only(bottom: AppSize.s12),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppPadding.p8),
            boxShadow: [
              AppShadow.boxShadow()!
            ]
        ),
        child: Row(
          children: [
            SvgPicture.asset(leadingIcon),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: CustomTextView(
                  txt:title,
                  textStyle: themeData.textTheme.headline2),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            if(Get.locale == LocalizationService.localeEn && trailingIcon == AppMedia.arrowIos)...[
              const Icon(Icons.arrow_forward_ios),
            ]else...[
              SvgPicture.asset(trailingIcon)
            ]
          ],
        ),
      ),
    );
  }
//this for items in the below to go to another pages
  Widget _profileDeleteAccount(ThemeData themeData , {required String title,  required String trailingIcon}) {
    return Container(
      width: double.infinity,
      height: AppSize.s50,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      margin:const EdgeInsets.only(bottom: AppSize.s12),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppPadding.p8),
          boxShadow: [
            AppShadow.boxShadow()!
          ]
      ),
      child: Row(
        children: [

          Expanded(
            child: CustomTextView(
                txt:title,
                textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.error)),
          ),
          const SizedBox(
            width: AppSize.s20,
          ),
          if(Get.locale == LocalizationService.localeEn && trailingIcon == AppMedia.arrowIos)...[
            const Icon(Icons.arrow_forward_ios),
          ]else...[
            SvgPicture.asset(trailingIcon)
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(
            top: AppSize.s50, left: AppPadding.p16, right: AppPadding.p16),
        decoration: BoxDecoration(color: themeData.scaffoldBackgroundColor),
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextView(
                      txt: AppStrings.txtAccount.tr,
                      textStyle: themeData.textTheme.headline1
                          ?.copyWith(color: AppColor.primary),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    _userCardData(themeData),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s65,
              ),
              _profileItem(themeData,onClick:_verifyAccount,leadingIcon:AppMedia.verify ,title:AppStrings.txtVerifyAccount.tr ,trailingIcon:AppMedia.done ),
              _profileItem(themeData,onClick: _termsAndCondition,leadingIcon:AppMedia.termsAndConditions ,title:AppStrings.txtTermsAndConditions.tr ,trailingIcon:AppMedia.arrowIos ),
              _profileItem(themeData,onClick:_onPrivacyPolicy,leadingIcon:AppMedia.privacyPolicies ,title:AppStrings.txtPrivacyPolicies.tr ,trailingIcon:AppMedia.arrowIos ),
              _profileItem(themeData,onClick:_onLogout,leadingIcon:AppMedia.logout ,title:AppStrings.txtLogout.tr ,trailingIcon:AppMedia.arrowIos ),
              _profileItem(themeData,onClick:_onGetMoneyPage,leadingIcon:AppMedia.currency ,title:AppStrings.txtCurrency.tr ,trailingIcon:AppMedia.arrowIos ),
              _profileDeleteAccount(themeData ,title: AppStrings.txtDeleteAccount.tr,trailingIcon:  AppMedia.arrowIos)
            ],
          ),
        ),
      ),
    );
  }




 String _completedConcatenations() {
    return AppStrings.txtCompleted.tr + " 5 " + AppStrings.txtExercises.tr;
 }

  String _balanceConcatenations() {
    return AppStrings.txtBalance.tr + " 5 " + AppStrings.txtCurrency.tr;
  }

  void _verifyAccount() {
      Get.to(()=> const AccountVerifyView());
  }


  void _termsAndCondition() {
    Get.to(()=> const TermsConditionView());
  }

  void _onPrivacyPolicy() {
    Get.to(()=> const PrivacyPolicyWidget());
  }

  void _onLogout() {
  }

  void _onGetMoneyPage() {
    Get.to(()=> const MoneyCollectView());
  }
}
