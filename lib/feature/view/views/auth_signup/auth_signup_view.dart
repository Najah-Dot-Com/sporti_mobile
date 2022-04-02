import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/appLogo.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import '../../appwidget/authwellcomeRow.dart';
import '../../appwidget/sportiTextField.dart';
import 'widget/checkBoxOfTerms.dart';
import '../auth_login/auth_login_view.dart';

// ignore: must_be_immutable
class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  bool acceptPolicy = false;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.primary,
      bottomSheet: Container(
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s28 , vertical: AppSize.s40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: _onTermsClick,
                child: CustomTextView(
                  txt: "terms and conditions",
                  textStyle: themeData.textTheme.subtitle2
                      ?.copyWith(color: AppColor.black),
                ),
              ),
              const SizedBox(width: AppSize.s10,),
              CustomTextView(
                txt: AppStrings.or.tr,
                textStyle:
                themeData.textTheme.subtitle2?.copyWith(color: AppColor.grey),
              ),
              const SizedBox(width: AppSize.s10,),
              InkWell(
                onTap: _onPrivacyClick,
                child: CustomTextView(
                  txt: "privacy policy",
                  textStyle: themeData.textTheme.subtitle2
                      ?.copyWith(color: AppColor.black),
                ),
              ),
            ],
          ),
        ),
      ),
      // appBar contains logo and welcome strings
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.primary,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: Column(
          children: [
            AppLogo(
                height: AppSize.s120,
                width: AppSize.s120,
                logoColor: AppColor.white),
            // const SizedBox(height: AppSize.s20),
            //this for login "welcome" and "choose language" text.
            const WelcomeRow(),
          ],
        ),
        toolbarHeight: AppSize.s220,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.s70,
                      left: AppPadding.p50,
                      right: AppPadding.p50,
                      bottom: AppPadding.p20),
                  child: Column(
                    children: [
                      //this for username TextFiled
                      SportiTextField(
                        hint: AppStrings.username.tr,
                        isforPass: false,
                        // controller: , TODO:
                      ),
                      const SizedBox(height: AppSize.s50),
                      //this for password TextFiled
                      SportiTextField(
                        hint: AppStrings.password.tr,
                        isforPass: true,
                        // controller: , TODO:
                      ),
                      const SizedBox(height: AppSize.s50),
                      //this for password TextFiled
                      SportiTextField(
                        hint: AppStrings.repassword.tr,
                        isforPass: true,
                        // controller: , TODO:
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      //this for checkBox of terms and policy
                      TermsAndPrivacyCheckBox(
                        getColor: AppColor.getColor,
                        acceptPolicy: acceptPolicy,
                        onTap: () {
                          //TODO: need for state for to change checkedBox
                        },
                        onChange: (value) {
                          //TODO: need for state 
                          acceptPolicy = value;
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      //this btn for signin
                      CustomButton(
                        height: AppSize.s60,
                        label: AppStrings.justSign.tr,
                        width: AppSize.s350,
                        primaryColor: AppColor.primary,
                        labelcolor: AppColor.white,
                        borderColor: AppColor.primary,
                        isRoundedBorder: true,
                        onTap: () => Get.offAll(LoginView()),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => Get.offAll(LoginView()),
                                child:
                              CustomTextView(txt: AppStrings.signin.tr,textStyle: themeData.textTheme.headline6 ?.copyWith(color: AppColor.darkYellow),),
                              ),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              CustomTextView(txt: AppStrings.iHaveAccount.tr,textStyle: themeData.textTheme.subtitle2?.copyWith(color: AppColor.black),),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onPrivacyClick() {
    Get.to(const PrivacyPolicyWidget());
  }

  void _onTermsClick() {
    Get.to(const TermsConditionView());
  }

}
