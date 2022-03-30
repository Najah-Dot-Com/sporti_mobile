import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/appLogo.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';
import '../../appwidget/authwellcomeRow.dart';
import '../../appwidget/sportiTextField.dart';
import '../../appwidget/checkBoxOfTerms.dart';
import '../auth_login/auth_login_view.dart';

// ignore: must_be_immutable
class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  bool acceptPolicy = false;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        // appBar contains logo and welcome strings
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.primary,
          title: Column(
            children: [
              AppLogo(
                  height: AppSize.s160,
                  width: AppSize.s160,
                  logoColor: AppColor.white),
              const SizedBox(height: AppSize.s20),
              //this for login "welcome" and "choose language" text.
              const WellcomeRow(),
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
                        top: AppPadding.p100,
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
                        //this for checkBox of terms and policy
                        TermsAndPrivacyCheckBox(
                          getColor: AppColor.getColor,
                          acceptPolicy: acceptPolicy,
                          onTap: () {
                            //TODO: need for state for accept policy
                          },
                          onChange: (value) {
                            //TODO: need for state 
                            acceptPolicy = value;
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        //this btn for signin
                        CustomButton(
                          height: AppSize.s60,
                          label: AppStrings.justSign.tr,
                          width: AppSize.s350,
                          primaryColor: AppColor.primary,
                          labelcolor: AppColor.white,
                          borderColor: AppColor.primary,
                          onTap: () => Get.offAll(LoginView()),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
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
                        const SizedBox(
                          height: AppSize.s50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
