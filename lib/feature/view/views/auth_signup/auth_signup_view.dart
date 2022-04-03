import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/appLogo.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import '../../appwidget/authwellcomeRow.dart';
import '../../appwidget/sportiTextField.dart';
import 'widget/checkBoxOfTerms.dart';
import '../auth_login/auth_login_view.dart';

// ignore: must_be_immutable
class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  bool acceptPolicy = false;

  static final TextEditingController _fullnameController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passController = TextEditingController();
  static final TextEditingController _conPassController = TextEditingController();
  static final FocusNode _fullNameFocusNode = FocusNode();
  static final FocusNode _emailFocusNode = FocusNode();
  static final FocusNode _passFocusNode = FocusNode();
  static final FocusNode _conPassFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        toolbarHeight: AppSize.s160,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: ListView(
                children: [
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: AppSize.s50,
                          left: AppPadding.p50,
                          right: AppPadding.p50,
                          bottom: AppPadding.p20),
                      child: Column(
                        children: [
                          //this for username TextFiled
                          // SportiTextField(
                          //   hint: AppStrings.username.tr,
                          //   isforPass: false,
                          //   // controller: , TODO:
                          // ),
                          CustomTextFormFiled(
                            label: AppStrings.txtFullName.tr,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            isSmallPaddingWidth: true,
                            isBorder: true,
                            focusNode: _fullNameFocusNode,
                            nexFocusNode: _emailFocusNode,
                            controller: _fullnameController,
                            onSubmitted: (v){
                              if(v.isNotEmpty){
                                _emailFocusNode.requestFocus();
                              }
                            },
                          ),
                          const SizedBox(height: AppSize.s30),
                          CustomTextFormFiled(
                            label: AppStrings.username.tr,
                            keyboardType: TextInputType.emailAddress,
                            customValid: emailValid,
                            textInputAction: TextInputAction.next,
                            isSmallPaddingWidth: true,
                            isBorder: true,
                            focusNode: _emailFocusNode,
                            nexFocusNode: _passFocusNode,
                            controller: _emailController,
                            onSubmitted: (v){
                              if(v.isNotEmpty){
                                _passFocusNode.requestFocus();
                              }
                            },
                          ),
                          const SizedBox(height: AppSize.s30),
                          //this for password TextFiled
                          CustomTextFormFiled(
                            label: AppStrings.password.tr,
                            isBorder: true,
                            keyboardType: TextInputType.text,
                            customValid: passwordValid,
                            textInputAction: TextInputAction.next,
                            isSmallPaddingWidth: true,
                            focusNode: _passFocusNode,
                            nexFocusNode: _conPassFocusNode,
                            controller: _passController,
                            isSuffixIcon: true,
                            suffixIcon: Icons.visibility_off,
                            onSubmitted: (v){
                              if(v.isNotEmpty){
                                _conPassFocusNode.requestFocus();
                              }
                            },
                          ),
                          // SportiTextField(
                          //   hint: AppStrings.password.tr,
                          //   isforPass: true,
                          //   // controller: , TODO:
                          // ),
                          const SizedBox(height: AppSize.s30),
                          //this for password TextFiled
                          // SportiTextField(
                          //   hint: AppStrings.repassword.tr,
                          //   isforPass: true,
                          //   // controller: , TODO:
                          // ),
                          CustomTextFormFiled(
                            label: AppStrings.repassword.tr,
                            keyboardType: TextInputType.text,
                            customValid: passwordValid,
                            textInputAction: TextInputAction.done,
                            isSmallPaddingWidth: true,
                            isBorder: true,
                            focusNode: _conPassFocusNode,
                            nexFocusNode: _conPassFocusNode,
                            controller: _conPassController,
                            isSuffixIcon: true,
                            suffixIcon: Icons.visibility_off,
                            onSubmitted: (v){
                              if(v.isNotEmpty){
                                hideFocus(context);
                              }
                            },
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
                              _onTermsClick();
                            },
                            onChange: (value) {
                              //TODO: need for state 
                              acceptPolicy = value;
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          //this btn for signup
                          PrimaryButton(
                              textButton: AppStrings.justSign.tr,
                              colorBtn: AppColor.primary,
                              colorText:AppColor.white,
                              isLoading: false, onClicked: _onSignUpClick),
                          // CustomButton(
                          //   height: AppSize.s60,
                          //   label: AppStrings.justSign.tr,
                          //   width: AppSize.s350,
                          //   primaryColor: AppColor.primary,
                          //   labelcolor: AppColor.white,
                          //   borderColor: AppColor.primary,
                          //   isRoundedBorder: true,
                          //   onTap: () => Get.offAll(const LoginView()),
                          // ),
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
                                    onPressed: () => Get.offAll(const LoginView()),
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
                ],
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


  _onSignUpClick() {
  }
}
