import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/language_bottom_sheet.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/logout_bottom_sheet.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/social_bottom_sheet.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/account_verfiy/account_verfiy_view.dart';
import 'package:sporti/feature/view/views/chat/admin/create_group/create_group_view.dart';
import 'package:sporti/feature/view/views/money_collect/money_collect_view.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/subscriptions/my_current_subscriptions/my_cureent_subscriptions_view.dart';
import 'package:sporti/feature/view/views/update_profile/update_profile_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
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
import 'package:sporti/util/sh_util.dart';

import '../../../viewmodel/privacyPolicy_viewmodel.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  static var img =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80";

  Widget _userCardData(ThemeData themeData) {
    UserData? userData = SharedPref.instance.getUserData();
    return GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (logic) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                  // borderRadius: BorderRadius.circular(AppPadding.p18),
                  child: (logic.isDoneUploadImage && logic.filePath != null)
                      ? Image.file(logic.filePath!,
                          width: AppSize.s90,
                          height: AppSize.s90,
                          fit: BoxFit.cover)
                      : (userData.picture != null &&
                              userData.picture!.isNotEmpty &&
                              !userData.picture!.contains("http") && !userData.picture!.contains("."))
                          ? Image.memory(
                              base64Decode(userData.picture.toString()),
                              width: AppSize.s90,
                              height: AppSize.s90,
                              fit: BoxFit.cover)
                          : imageNetwork(
                              url: (userData.picture != null &&
                                      userData.picture!.isNotEmpty)
                                  ? userData.picture
                                  : null,
                              width: AppSize.s90,
                              height: AppSize.s90,
                              fit: BoxFit.cover)),
              const SizedBox(
                width: AppSize.s20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextView(
                      txt: SharedPref.instance.getUserData().fullname,
                      maxLine: Constance.maxLineOne,
                      textAlign: TextAlign.start,
                      textOverflow: TextOverflow.ellipsis,
                      textStyle: themeData.textTheme.headline2
                          ?.copyWith(fontSize: AppFontSize.s18),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    CustomTextView(
                      txt: _completedConcatenations(),
                      maxLine: Constance.maxLineOne,
                      textAlign: TextAlign.start,
                      textOverflow: TextOverflow.ellipsis,
                      textStyle: themeData.textTheme.headline2
                          ?.copyWith(fontSize: AppFontSize.s18 , color: AppColor.primary),
                    ),
                    // const SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    // CustomTextView(
                    //   txt: _balanceConcatenations(),
                    //   maxLine: Constance.maxLineOne,
                    //   textAlign: TextAlign.start,
                    //   textOverflow: TextOverflow.ellipsis,
                    //   textStyle: themeData.textTheme.headline2
                    //       ?.copyWith(fontSize: AppFontSize.s18),
                    // ),
                  ],
                ),
              ),
              InkWell(
                onTap: _onDeleteAccountClick,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),]
                  ),
                  child: SvgPicture.asset(
                    AppMedia.deleteAccountIcons , fit: BoxFit.cover,),
                ),
              ),

            ],
          );
        });
  }

//this for items in the below to go to another pages
  Widget _profileDeleteAccount(ThemeData themeData,
      {required Function() onClick,
      required String title,
      required String trailingIcon}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: AppSize.s50,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        margin: const EdgeInsets.only(bottom: AppSize.s12),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppPadding.p8),
            /*boxShadow: [AppShadow.boxShadow()!]*/),
        child: Row(
          children: [
            SvgPicture.asset(AppMedia.logoutIcons ,/*color: AppColor.primary,*/),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: CustomTextView(
                  txt: title,
                  textStyle: themeData.textTheme.headline2
                      ?.copyWith(color: AppColor.darkYellow)),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            // if (Get.locale == LocalizationService.localeEn &&
            //     trailingIcon == AppMedia.arrowIos) ...[
            //   const Icon(Icons.arrow_forward_ios),
            // ] else ...[
            //   SvgPicture.asset(trailingIcon)
            // ]
          ],
        ),
      ),
    );
  }

  //this for items in the below to go to another pages
  Widget _profileLanguage(
    ThemeData themeData, {
    required Function() onClick,
    required String title,
  }) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: AppSize.s50,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        margin: const EdgeInsets.only(bottom: AppSize.s12),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppPadding.p8),
            /*boxShadow: [AppShadow.boxShadow()!]*/),
        child: Row(
          children: [
            SvgPicture.asset(AppMedia.langIcons ,color: AppColor.primary,),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: CustomTextView(
                  txt: title,
                  textStyle: themeData.textTheme.headline2
                      ?.copyWith(color: AppColor.black)),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            if (Get.locale == LocalizationService.localeEn /*&&
                trailingIcon == AppMedia.arrowIos*/) ...[
              const Icon(Icons.arrow_forward_ios),
            ] else ...[
              SvgPicture.asset(AppMedia.arrowIos)
            ]
            // SvgPicture.asset(AppMedia.arrowIos),
            // if (Get.locale == LocalizationService.localeEn) ...[
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            //     child: CustomTextView(
            //       txt: "عربي",
            //       textStyle: themeData.textTheme.headline2
            //           ?.copyWith(color: AppColor.black),
            //     ),
            //   ),
            // ] else ...[
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            //     child: CustomTextView(
            //       txt: "English",
            //       textStyle: themeData.textTheme.headline2
            //           ?.copyWith(color: AppColor.black),
            //     ),
            //   ),
            // ]
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:
            const EdgeInsets.only(left: AppPadding.p16, right: AppPadding.p16),
        decoration: BoxDecoration(color: AppColor.white/*themeData.scaffoldBackgroundColor*/),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: AppSize.s50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CustomTextView(
                    //   txt: AppStrings.txtAccount.tr,
                    //   textStyle: themeData.textTheme.headline1
                    //       ?.copyWith(color: AppColor.primary),
                    // ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    _userCardData(themeData),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s65,
              ),
              CustomTextView(
                  txt: AppStrings.txtAccount.tr, textStyle: themeData.textTheme.headline2?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: AppSize.s12,
              ),
              profileItem(themeData,
                  onClick: _updateProfile,
                  leadingIcon: AppMedia.profileUser/*AppMedia.personIcon*/,
                  title: AppStrings.txtUpdateProfile.tr,
                  trailingIcon: AppMedia.arrowIos),
              if (!SharedPref.instance.getUserData().isVerify!)
                profileItem(themeData,
                    onClick: _verifyAccount,
                    leadingIcon: AppMedia.verify,
                    title: AppStrings.txtVerifyAccount.tr,
                    trailingIcon: AppMedia.done),
              profileItem(themeData,
                  onClick: _onSubscriptionsPage,
                  leadingIcon: AppMedia.subscriptions,
                  title: AppStrings.txtSubscriptions.tr,
                  trailingIcon: AppMedia.arrowIos),
              profileItem(themeData,
                  onClick: _onGetMoneyPage,
                  leadingIcon: AppMedia.earningIcons/*AppMedia.currency*/,
                  title: AppStrings.txtCurrency.tr,
                  trailingIcon: AppMedia.arrowIos),
              //_profileItem(themeData,onClick:_onUpdatePassword,leadingIcon:AppMedia.resetPassword ,title:AppStrings.resetYourPass.tr ,trailingIcon:AppMedia.arrowIos),

              const SizedBox(
                height: AppSize.s50,
              ),
              CustomTextView(
                  txt: AppStrings.txtApp.tr, textStyle: themeData.textTheme.headline2?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: AppSize.s12,
              ),
              if(SharedPref.instance.getAdminListHandler().contains(SharedPref.instance.getUserData().email.toString()))
              profileItem(themeData,
                onClick:  _onCreateForum,
                title: AppStrings.txtCreateForum.tr,
                trailingIcon: AppMedia.arrowIos,
                leadingIcon: "",
              ),
              profileItem(themeData,
                  onClick: _termsAndCondition,
                  leadingIcon: AppMedia.termsAndConditions,
                  title: AppStrings.txtTermsAndConditions.tr,
                  trailingIcon: AppMedia.arrowIos),
              profileItem(themeData,
                  onClick: _onPrivacyPolicy,
                  leadingIcon: AppMedia.privacyPolicies,
                  title: AppStrings.txtPrivacyPolicies.tr,
                  trailingIcon: AppMedia.arrowIos),
              _profileLanguage(
                themeData,
                onClick: _onChangeLang,
                title: AppStrings.chooseLanguage.tr,
              ),
              profileItem(themeData,
                  onClick: _onShareApp,
                  leadingIcon: AppMedia.share,
                  title: AppStrings.txtShareApp.tr,
                  trailingIcon: /*AppMedia.arrowIos*/""),
              // profileItem(themeData,
              //     onClick: _onLogout,
              //     leadingIcon: AppMedia.logout,
              //     title: AppStrings.txtLogout.tr,
              //     trailingIcon: AppMedia.arrowIos),
              _profileDeleteAccount(themeData,
                  onClick:_onLogout /*_onDeleteAccountClick*/,
                  title: AppStrings.txtLogout.tr/*AppStrings.txtDeleteAccount.tr*/,
                  trailingIcon: AppMedia.arrowIos),
              const SizedBox(
                height: AppSize.s30,
              ),
              Image.asset(AppMedia.companyLogoNajah , width: AppSize.s70,height: AppSize.s50,),
              const SizedBox(
                height: AppSize.s10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _onWebsiteClick,
                    child: CustomTextView(
                        txt: AppStrings.website.tr,
                        textStyle: themeData.textTheme.headline3
                            ?.copyWith(color: AppColor.black)),
                  ),
                  const SizedBox(
                    width: AppSize.s10,
                  ),
                  CustomTextView(
                      txt: "|",
                      textStyle: themeData.textTheme.headline3
                          ?.copyWith(color: AppColor.black)),
                  const SizedBox(
                    width: AppSize.s10,
                  ),
                  InkWell(
                    onTap: _onSocialMediaClick,
                    child: CustomTextView(
                        txt: AppStrings.socialMedia.tr,
                        textStyle: themeData.textTheme.headline3
                            ?.copyWith(color: AppColor.black)),
                  )
                ],
              ),
              const SizedBox(
                height: AppSize.s150,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _completedConcatenations() {
    return AppStrings.txtCompleted.tr +
        " ${SharedPref.instance.getUserData().finish} " /*+ AppStrings.txtExercises.tr*/;
  }

  String _balanceConcatenations() {
    return AppStrings.txtBalance.tr +
        " ${formatStringWithCurrency(SharedPref.instance.getUserData().balance.toString())} " /*+ AppStrings.txtCurrency.tr*/;
  }

  void _updateProfile() async {
    await showIsVerifyDialog(isNeedSubscriptions: false).then((value) {
      if (value) {
        Get.to(() => UpdateProfileView());
      }
    });
  }

  void _verifyAccount() async {
    if (SharedPref.instance.getUserData().username ==
        Constance.guestUserNameKey) {
      await showIsVerifyDialog(isNeedSubscriptions: false);
    } else {
      Get.to(() => AccountVerifyView());
    }
  }

  final PrivacyPolicyViewModel _privacyAndTerms =
      Get.put<PrivacyPolicyViewModel>(
    PrivacyPolicyViewModel(), /* permanent: true */
  );

  void _termsAndCondition() {
    // _privacyAndTerms.getPrivacyAndTermsPages();
    Get.to(() => TermsConditionView());
  }

  void _onPrivacyPolicy() {
    // _privacyAndTerms.getPrivacyAndTermsPages();
    Get.to(
      () => PrivacyPolicyWidget(),
    );
  }

  void _onLogout() {
    Get.bottomSheet(const LogoutBottomSheet());
  }

  void _onGetMoneyPage() async {
    await showIsVerifyDialog(isNeedSubscriptions: false).then((value) {
      if (value) {
        Get.to(() => const MoneyCollectView());
      }
    });
  }

  // _onUpdatePassword() {
  //   Get.to(()=> const UpdatePasswordView());
  // }

  _onDeleteAccountClick() {
    Get.bottomSheet(const LogoutBottomSheet(
      isDeleteAccount: true,
    ));
  }

  _onChangeLang() {
    Get.bottomSheet(const LanguageBottomSheet(
      // isDeleteAccount: true,
    ));
    // LogoutBottomSheet
    // if (Get.locale == LocalizationService.localeEn) {
    //   SharedPref.instance
    //       .setAppLang(LocalizationService.langs[LocalizationService.arIndex]);
    // } else {
    //   SharedPref.instance
    //       .setAppLang(LocalizationService.langs[LocalizationService.enIndex]);
    // }
  }

  _onSubscriptionsPage() async {
    await showIsVerifyDialog(isNeedSubscriptions: false).then((value) {
      if (value) {
        Get.to(const MyCurrentSubscriptionsView());
      }
    });
  }

  void _onWebsiteClick() async{
    await openBrowser("https://hiconception.com/index.php/sporti/");/*https://naja7.net*/
  }

  void _onSocialMediaClick() {
    Get.bottomSheet(const SocialBottomSheet());
  }

  void _onCreateForum() {
    Get.to(const CreateGroupView());
  }

  _onShareApp() {
    Share.share('https://hiconception.com/index.php/sporti/');
  }
}
