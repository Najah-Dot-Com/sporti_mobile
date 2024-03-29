import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/appwidget/appLogo.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import '../../../viewmodel/privacyPolicy_viewmodel.dart';
import '../../appwidget/authwellcomeRow.dart';
import '../../appwidget/sportiTextField.dart';
import 'widget/checkBoxOfTerms.dart';
import '../auth_login/auth_login_view.dart';

// ignore: must_be_immutable
class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  // bool acceptPolicy = false;

  static final TextEditingController _fullnameController = TextEditingController();
  static final TextEditingController _userNameController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passController = TextEditingController();
  static final TextEditingController _conPassController = TextEditingController();
  static final FocusNode _fullNameFocusNode = FocusNode();
  static final FocusNode _userNameFocusNode = FocusNode();
  static final FocusNode _emailFocusNode = FocusNode();
  static final FocusNode _passFocusNode = FocusNode();
  static final FocusNode _conPassFocusNode = FocusNode();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  Widget bottomSheetWidget(ThemeData themeData) {
    return Container(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s28, vertical: AppSize.s40),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primary,
      bottomSheet: bottomSheetWidget(themeData),
      // appBar contains logo and welcome strings
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.primary,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: Padding(
          padding: const EdgeInsets.only(top:13.0),
          child: Column(
            children: [
              AppLogo(
                  height: AppSize.s110,
                  width: AppSize.s110,
                  logoColor: AppColor.white),
              // const SizedBox(height: AppSize.s20),
              //this for login "welcome" and "choose language" text.
              const WelcomeRow(),
            ],
          ),
        ),
        toolbarHeight: AppSize.s160,
      ),
      body: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (logic) {
        return Column(
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
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppSize.s40,
                          left: AppPadding.p50,
                          right: AppPadding.p50,
                          bottom: AppPadding.p20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormFiled(
                              label: AppStrings.txtFullName.tr,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              isSmallPaddingWidth: true,
                              isBorder: true,
                              focusNode: _fullNameFocusNode,
                              nexFocusNode: _userNameFocusNode,
                              controller: _fullnameController,
                              onSubmitted: (v) {
                                if (v.isNotEmpty) {
                                  _userNameFocusNode.requestFocus();
                                }
                              },
                            ),
                            const SizedBox(height: AppSize.s24),
                            CustomTextFormFiled(
                              label: AppStrings.username.tr,
                              keyboardType: TextInputType.emailAddress,
                               customValid: (v){
                                if(v.length < 4){
                                  return AppStrings.txtForLength.tr;
                                }
                                return null;
                               },
                              textInputAction: TextInputAction.next,
                              isSmallPaddingWidth: true,
                              isBorder: true,
                              focusNode: _userNameFocusNode,
                              nexFocusNode: _emailFocusNode,
                              controller: _userNameController,
                              onSubmitted: (v) {
                                if (v.isNotEmpty) {
                                  _emailFocusNode.requestFocus();
                                }
                              },
                            ),
                            const SizedBox(height: AppSize.s24),
                            CustomTextFormFiled(
                              label: AppStrings.txtEmail.tr,
                              keyboardType: TextInputType.emailAddress,
                              customValid: emailValid,
                              textInputAction: TextInputAction.next,
                              isSmallPaddingWidth: true,
                              isBorder: true,
                              focusNode: _emailFocusNode,
                              nexFocusNode: _passFocusNode,
                              controller: _emailController,
                              onSubmitted: (v) {
                                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                if (v.isNotEmpty) {
                                  _passFocusNode.requestFocus();
                                }
                              },
                            ),
                            const SizedBox(height: AppSize.s24),
                            //this for password TextFiled
                            CustomTextFormFiled(
                              label: AppStrings.password.tr,
                              isBorder: true,
                              keyboardType: TextInputType.text,
                              customValid: passwordValid,
                              textInputAction: TextInputAction.next,
                              isSmallPaddingWidth: true,
                              obscureText: true,
                              focusNode: _passFocusNode,
                              nexFocusNode: _conPassFocusNode,
                              controller: _passController,
                              isSuffixIcon: true,
                              suffixIcon: Icons.visibility_off,
                              onSubmitted: (v) {
                                if (v.isNotEmpty) {
                                  _conPassFocusNode.requestFocus();
                                }
                              },
                            ),
                            const SizedBox(height: AppSize.s24),
                            CustomTextFormFiled(
                              label: AppStrings.repassword.tr,
                              keyboardType: TextInputType.text,
                              customValid: passwordValid,
                              textInputAction: TextInputAction.done,
                              isSmallPaddingWidth: true,
                              isBorder: true,
                              obscureText: true,
                              focusNode: _conPassFocusNode,
                              nexFocusNode: _conPassFocusNode,
                              controller: _conPassController,
                              isSuffixIcon: true,
                              suffixIcon: Icons.visibility_off,
                              onSubmitted: (v) {
                                if (v.isNotEmpty) {
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
                              acceptPolicy: logic.acceptPolicy,
                              onTap: () {
                                //TODO: need for state for to change checkedBox
                                _onTermsClick();
                              },
                              onChange: (value) {
                                //TODO: need for state 
                                 logic.onAcceptChange();
                              },
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            //this btn for signup
                            PrimaryButton(
                                textButton: AppStrings.justSign.tr,
                                colorBtn: AppColor.primary,
                                colorText: AppColor.white,
                                isLoading: logic.isLoading,
                                onClicked:()=> _onSignUpClick(logic)),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextView(
                                      txt: AppStrings.iHaveAccount.tr,
                                      textStyle: themeData.textTheme.subtitle2
                                          ?.copyWith(color: AppColor.black),),
                                    const SizedBox(
                                      width: AppSize.s8,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Get.offAll( LoginView()),
                                      child:
                                      CustomTextView(txt: AppStrings.signin.tr,
                                        textStyle: themeData.textTheme.headline6
                                            ?.copyWith(
                                            color: AppColor.darkYellow),),
                                    ),
                                  ],
                                ),
                                 const SizedBox(height: AppSize.s100),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s50,
            ),
          ],
        );
      }),
    );
  }

  final PrivacyPolicyViewModel _privacyAndTerms =
      Get.put<PrivacyPolicyViewModel>(PrivacyPolicyViewModel(),);

  void _onPrivacyClick() {
    // _privacyAndTerms.getPrivacyAndTermsPages();
    Get.to(()=>PrivacyPolicyWidget());
  }
  void _onTermsClick() {
    // _privacyAndTerms.getPrivacyAndTermsPages();
    Get.to(()=>TermsConditionView());
  }


  _onSignUpClick(AuthViewModel logic) {
    bool isValidate = _formKey.currentState!.validate();
    if(isValidate){
      _formKey.currentState?.save();
      logic.signUpValid(_userNameController, _passController,
          _conPassController, _fullnameController, _emailController);
    }
  }
}
