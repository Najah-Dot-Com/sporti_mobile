import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/appLogo.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/auth_forgetpassword/auth_forgetpassword_view.dart';
import 'package:sporti/feature/view/views/auth_signup/auth_signup_view.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import '../../appwidget/authwellcomeRow.dart';
import '../../appwidget/custome_text_view.dart';
import '../../appwidget/sportiTextField.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  static final TextEditingController _passController = TextEditingController();
  static final TextEditingController _userNameController = TextEditingController();
  static final FocusNode _userNameFocusNode = FocusNode();
  static final FocusNode _passFocusNode = FocusNode();
  const LoginView({Key? key}) : super(key: key);

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        elevation: 0.0,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        backgroundColor: AppColor.primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(
                height: AppSize.s120,
                width: AppSize.s120,
                logoColor: AppColor.white),
            // const SizedBox(height: AppSize.s10),
            //this for login "welcome" and "choose language" text.
            const WelcomeRow(),
          ],
        ),
        toolbarHeight: AppSize.s160,
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.primary,
      resizeToAvoidBottomInset: false,
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
                  txt: AppStrings.txtTermsAndConditions.tr,
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
                  txt: AppStrings.txtPrivacyPolicies.tr,
                  textStyle: themeData.textTheme.subtitle2
                      ?.copyWith(color: AppColor.black),
                ),
              ),
            ],
          ),
        ),
      ),
      // appBar contains logo and welcome strings
      appBar: myAppbar(themeData),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.only(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //this for username TextFiled
                      // SportiTextField(
                      //   hint: AppStrings.username.tr,
                      //   isforPass: false,
                      //   // controller: , TODO:
                      // ),
                      CustomTextFormFiled(
                        label: AppStrings.username.tr,
                        keyboardType: TextInputType.emailAddress,
                        customValid: emailValid,
                        textInputAction: TextInputAction.next,
                        isSmallPaddingWidth: true,
                        isBorder: true,
                        focusNode: _userNameFocusNode,
                        nexFocusNode: _passFocusNode,
                        controller: _userNameController,
                        onSubmitted: (v){
                          if(v.isNotEmpty){
                            _passFocusNode.requestFocus();
                          }
                        },
                      ),
                      const SizedBox(height: AppSize.s40),
                      //this for password TextFiled
                      // SportiTextField(
                      //   hint: AppStrings.password.tr,
                      //   isforPass: true,
                      //   // controller: , TODO:
                      // ),
                      CustomTextFormFiled(
                        label: AppStrings.password.tr,
                        isBorder: true,
                        keyboardType: TextInputType.text,
                        customValid: passwordValid,
                        textInputAction: TextInputAction.next,
                        isSmallPaddingWidth: true,
                        controller: _passController,
                        focusNode: _passFocusNode,
                        isSuffixIcon: true,
                        suffixIcon: Icons.visibility_off,
                        onSubmitted: (v){
                          if(v.isNotEmpty){
                            hideFocus(context);
                          }
                        },
                      ),
                      //this for checkBox of terms and policy
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      InkWell(
                        onTap: _onForgetPassClick,
                        child: CustomTextView(
                          txt: AppStrings.txtForgetPassword.tr,
                          textStyle: themeData.textTheme.subtitle2
                              ?.copyWith(color: AppColor.black),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      //this btn for signin
                      // CustomButton(
                      //   height: AppSize.s60,
                      //   label: AppStrings.signin.tr,
                      //   width: AppSize.s350,
                      //   primaryColor: AppColor.primary,
                      //   labelcolor: AppColor.white,
                      //   borderColor: AppColor.primary,
                      //   isRoundedBorder: true,
                      //   onTap: _onSignInClick,
                      // ),
                      PrimaryButton(
                          textButton: AppStrings.signin.tr,
                          colorBtn: AppColor.primary,
                          colorText:AppColor.white,
                          isLoading: false, onClicked: _onSignInClick),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Center(
                        child: CustomTextView(
                          txt: AppStrings.or.tr,
                          textStyle: themeData.textTheme.headline5
                              ?.copyWith(color: AppColor.black),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      //this btn for new signup
                      CustomButton(
                        height: AppSize.s60,
                        label: AppStrings.newSignin.tr,
                        width: AppSize.s350,
                        primaryColor: AppColor.white,
                        labelcolor: AppColor.primary,
                        borderColor: AppColor.primary,
                        isRoundedBorder: true,
                        onTap: () => Get.offAll(SignupView()),
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

  void _onForgetPassClick() {
    Get.to(const ForgetPasswordView());
  }

  void _onPrivacyClick() {
    Get.to(const PrivacyPolicyWidget());
  }

  void _onTermsClick() {
    Get.to(const TermsConditionView());
  }

  _onSignInClick() {
    Get.to(const HomePageView());
  }
}
