import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/fcm/app_fcm.dart';
import 'package:sporti/feature/view/appwidget/appLogo.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/appwidget/three_size_dot.dart';
import 'package:sporti/feature/view/views/auth_forgetpassword/auth_forgetpassword_view.dart';
import 'package:sporti/feature/view/views/auth_signup/auth_signup_view.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/feature/view/views/privacy_policy/privacy_policy_view.dart';
import 'package:sporti/feature/view/views/terms_conditions/terms_conditions_view.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import '../../../viewmodel/privacyPolicy_viewmodel.dart';
import '../../appwidget/authwellcomeRow.dart';
import '../../appwidget/custome_text_view.dart';
import '../../appwidget/sportiTextField.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {

   LoginView({Key? key}) : super(key: key);


  static final TextEditingController _passController = TextEditingController();
  static final TextEditingController _userNameController = TextEditingController();
  static final FocusNode _userNameFocusNode = FocusNode();
  static final FocusNode _passFocusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // AuthViewModel get viewModel => Get.put<AuthViewModel>(AuthViewModel());


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

  Widget bottomSheetWidget (ThemeData themeData){
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
      backgroundColor: AppColor.primary,
      resizeToAvoidBottomInset: false,
      bottomSheet: bottomSheetWidget(themeData),
      // appBar contains logo and welcome strings
      appBar: myAppbar(themeData),
      body: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          initState: (state){
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              AppFcm.fcmInstance.getTokenFCM();
            });
          },
          builder: (logic) {
        return Column(
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
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: AppSize.s50,
                        left: AppPadding.p50,
                        right: AppPadding.p50,
                        bottom: AppPadding.p20),
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormFiled(
                          label: AppStrings.username.tr,
                          keyboardType: TextInputType.name,
                          // customValid: emailValid,
                          textInputAction: TextInputAction.next,
                          isSmallPaddingWidth: true,
                          isBorder: true,
                          focusNode: _userNameFocusNode,
                          nexFocusNode: _passFocusNode,
                          controller: _userNameController,
                          onSubmitted: (v) {
                            if (v.isNotEmpty) {
                              _passFocusNode.requestFocus();
                            }
                          },
                        ),
                        const SizedBox(height: AppSize.s40),
                        CustomTextFormFiled(
                          label: AppStrings.password.tr,
                          isBorder: true,
                          keyboardType: TextInputType.visiblePassword,
                          customValid: passwordValid,
                          textInputAction: TextInputAction.next,
                          isSmallPaddingWidth: true,
                          obscureText: true,
                          controller: _passController,
                          focusNode: _passFocusNode,
                          isSuffixIcon: true,
                          suffixIcon: Icons.visibility_off,
                          onSubmitted: (v) {
                            if (v.isNotEmpty) {
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
                        PrimaryButton(
                            textButton: AppStrings.signin.tr,
                            colorBtn: AppColor.primary,
                            colorText: AppColor.white,
                            isLoading: logic.isLoading,
                            onClicked: ()=>_onSignInClick(logic)),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        InkWell(
                          onTap: ()=>_onSignInClickSkip(logic),
                          child: Center(
                            child: logic.isLoadingSkip ? ThreeSizeDot(
                              color_1: AppColor.black,
                              color_2: AppColor.black,
                              color_3: AppColor.black,
                            ):CustomTextView(
                              txt: AppStrings.txtSkip.tr,
                              textAlign: TextAlign.center,
                              textStyle: themeData.textTheme.subtitle2
                                  ?.copyWith(color: AppColor.black),
                            ),
                          ),
                        ),

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
        );
      }),
    );
  }

  void _onForgetPassClick() {
    Get.to(ForgetPasswordView());
  }

  final PrivacyPolicyViewModel _privacyAndTerms =
      Get.put<PrivacyPolicyViewModel>(PrivacyPolicyViewModel(),permanent: true);
  
  void _onPrivacyClick() {
    // _privacyAndTerms.getPrivacyAndTermsPages();
    Get.to( ()  => PrivacyPolicyWidget());
  }

  void _onTermsClick() {
    // _privacyAndTerms.getPrivacyAndTermsPages();
    Get.to(()=>TermsConditionView());
  }

  _onSignInClick(AuthViewModel logic) {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.validate();
      logic.signInValid(_userNameController, _passController);
    }
  }
  _onSignInClickSkip(AuthViewModel logic) {
      logic.signInValidSkip(Constance.guestUserNameKey, Constance.guestUserPasswordKey);
  }
}
