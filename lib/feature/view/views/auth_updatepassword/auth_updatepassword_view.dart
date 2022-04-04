import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/appwidget/sportiTextField.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_strings.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  static final TextEditingController _oldPassController = TextEditingController();
  static final TextEditingController _newPassController = TextEditingController();
  static final TextEditingController _repeatPassController = TextEditingController();
  static final FocusNode _oldPassFocusNode = FocusNode();
  static final FocusNode _newPassFocusNode = FocusNode();
  static final FocusNode _rePassFocusNode = FocusNode();
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
                    txt: AppStrings.setNewPasss.tr,
                    textStyle: themeData.textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: AppSize.s50,
                  ),

                  CustomTextFormFiled(
                    label: AppStrings.txtOldPassword.tr,
                    isBorder: true,
                    keyboardType: TextInputType.text,
                    customValid: passwordValid,
                    textInputAction: TextInputAction.next,
                    isSmallPaddingWidth: true,
                    obscureText: true,
                    controller: _oldPassController,
                    focusNode: _oldPassFocusNode,
                    nexFocusNode: _newPassFocusNode,
                    isSuffixIcon: true,
                    suffixIcon: Icons.visibility_off,
                    onSubmitted: (v) {
                      if (v.isNotEmpty) {
                        _newPassFocusNode.requestFocus();
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  CustomTextFormFiled(
                    label: AppStrings.txtNewPassword.tr,
                    isBorder: true,
                    keyboardType: TextInputType.text,
                    customValid: passwordValid,
                    textInputAction: TextInputAction.next,
                    isSmallPaddingWidth: true,
                    obscureText: true,
                    controller: _newPassController,
                    focusNode: _newPassFocusNode,
                    nexFocusNode: _rePassFocusNode,
                    isSuffixIcon: true,
                    suffixIcon: Icons.visibility_off,
                    onSubmitted: (v) {
                      if (v.isNotEmpty) {
                        _rePassFocusNode.requestFocus();
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  CustomTextFormFiled(
                    label: AppStrings.repassword.tr,
                    isBorder: true,
                    keyboardType: TextInputType.text,
                    customValid: passwordValid,
                    textInputAction: TextInputAction.next,
                    isSmallPaddingWidth: true,
                    obscureText: true,
                    controller: _repeatPassController,
                    focusNode: _rePassFocusNode,
                    isSuffixIcon: true,
                    suffixIcon: Icons.visibility_off,
                    onSubmitted: (v) {
                      if (v.isNotEmpty) {
                        hideFocus(context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s70,
                  ),
                  PrimaryButton(textButton: AppStrings.update.tr,
                      colorBtn: AppColor.primary,
                      colorText: AppColor.white,
                      isLoading: logic.isLoading,
                      onClicked: ()=>_onUpdateClick(logic)),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _onUpdateClick(AuthViewModel logic) {
    logic.resetPassword(_oldPassController , _newPassController , _repeatPassController);
  }
}
