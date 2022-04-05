import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/sportiTextField.dart';
import 'package:sporti/feature/view/views/auth_resetpassword/auth_resetpassword_view.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_strings.dart';
import '../../../viewmodel/auth_viewmodle.dart';
import '../../appwidget/custom_text_filed.dart';
import '../../appwidget/primary_button.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);
  static final TextEditingController _emailController = TextEditingController();
  static final FocusNode _emailFocusNode = FocusNode();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p60, horizontal: AppPadding.p50),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: AppSize.s100,
                        height: AppSize.s100,
                        child: Image(
                          image: AssetImage(AppMedia.lockIcon),
                        )),
                    CustomTextView(
                      txt: AppStrings.resetYourPass.tr,
                      textStyle: themeData.textTheme.headline1,
                    ),
                    const SizedBox(
                      height: AppSize.s8,
                    ),
                    CustomTextView(
                      txt: AppStrings.setYourEmail.tr,
                      textStyle: themeData.textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: AppSize.s50,
                    ),
                    CustomTextFormFiled(
                              label: AppStrings.email.tr,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              isSmallPaddingWidth: true,
                              isBorder: true,
                              focusNode: _emailFocusNode,
                              controller: _emailController,
                              onSubmitted: (v) {
                                if (v.isNotEmpty) {
                                  _emailFocusNode.requestFocus();
                                }
                              },
                            ),
                    // SportiTextField(
                    //   hint: AppStrings.email.tr,
                    //   isforPass: false,
                    //   textInputType: TextInputType.emailAddress,
                    //   controller: _emailController,
                    // ),
                    const SizedBox(
                      height: AppSize.s100,
                    ),
                    PrimaryButton(
                      textButton: AppStrings.verify.tr,
                      colorBtn: AppColor.primary,
                      colorText: AppColor.white,
                      isLoading: logic.isLoading,
                      onClicked:()=> _onVerifyClick(logic)),
                    // CustomButton(
                    //   width: double.infinity,
                    //   height: AppSize.s60,
                    //   label: AppStrings.verify.tr,
                    //   labelcolor: AppColor.white,
                    //   isRoundedBorder: false,
                    //   primaryColor: AppColor.primary,
                    //   onTap: _onVerifyClick(logic),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onVerifyClick(AuthViewModel logic) {
    bool isValidate = _formKey.currentState!.validate();
    if (isValidate) {
      logic.verifyEmail(_emailController);
    }
  }
}
