// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/sh_util.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_dimen.dart';
import '../../../../util/app_font.dart';
import '../../../../util/app_media.dart';
import '../../../../util/app_shaerd_data.dart';
import '../../../viewmodel/auth_viewmodle.dart';
import '../auth_updatepassword/auth_updatepassword_view.dart';

class UpdateProfileView extends StatelessWidget {
  UpdateProfileView({Key? key}) : super(key: key);
  TextEditingController? _fullNameController = TextEditingController();
  TextEditingController? _emailController = TextEditingController();
  static final FocusNode _userNameFocusNode = FocusNode();
  static final FocusNode _emailFocusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AppBar appBar() {
    return AppBar(
      title: Text(
        AppStrings.txtUpdateProfile.tr,
        style: AppTextStyle.getBoldStyle(
            color: AppColor.primary, fontSize: AppFontSize.s18),
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
            size: AppSize.s24,
          )),
    );
  }

  Widget _userCardData(ThemeData themeData, BuildContext context,
      AuthViewModel logic, UserData userData) {
    return Container(
      width: AppSize.s160,
      height: AppSize.s160,
      child: Stack(
        children: [
          Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(AppSize.s8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppPadding.p18),
                  boxShadow: [AppShadow.boxShadowLight()!]),
              child: logic.filePath != null
                  ? Image.file(logic.filePath!,
                      width: AppSize.s150,
                      height: AppSize.s150,
                      fit: BoxFit.cover)
                  : (userData.picture != null &&
                          userData.picture!.isNotEmpty &&
                          !userData.picture!.contains("http") && !userData.picture!.contains("."))
                      ? Image.memory(base64Decode(userData.picture.toString()),
                          width: AppSize.s150,
                          height: AppSize.s150,
                          fit: BoxFit.cover)
                      : imageNetwork(
                           url:(userData.picture != null &&
                               userData.picture!.isNotEmpty) ?userData.picture:null,
                          width: AppSize.s150,
                          height: AppSize.s150,
                          fit: BoxFit.cover)),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: GestureDetector(
              child: CircleAvatar(
                radius: AppPadding.p20,
                backgroundColor: AppColor.primary,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColor.white,
                ),
              ),
              onTap: () {
                logic.showPicker(context);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: SingleChildScrollView(
          child: GetBuilder<AuthViewModel>(
              init: AuthViewModel(),
              initState: (state) {
                UserData? userData = SharedPref.instance.getUserData();
                _emailController?.text =
                    userData.email == null ? "" : userData.email.toString();
                _fullNameController?.text = userData.fullname.toString();
              },
              builder: (logic) {
                UserData? userData = SharedPref.instance.getUserData();
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      _userCardData(themeData, context, logic, userData),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      CustomTextFormFiled(
                        label: AppStrings.username.tr,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        isSmallPaddingWidth: true,
                        isBorder: true,
                        focusNode: _userNameFocusNode,
                        nexFocusNode: _emailFocusNode,
                        controller: _fullNameController,
                        onChange: (v) {
                          logic.update();
                        },
                        onSubmitted: (v) {
                          if (v.isNotEmpty) {
                            _emailFocusNode.requestFocus();
                          }
                        },
                      ),
                      const SizedBox(height: AppSize.s40),
                      CustomTextFormFiled(
                        label: AppStrings.txtEmail.tr,
                        isBorder: true,
                        keyboardType: TextInputType.emailAddress,
                        customValid: emailValid,
                        textInputAction: TextInputAction.next,
                        isSmallPaddingWidth: true,
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onChange: (v) {
                          logic.update();
                        },
                        onSubmitted: (v) {
                          if (v.isNotEmpty) {
                            hideFocus(context);
                          }
                        },
                      ),
                      const SizedBox(height: AppSize.s60),
                      profileItem(themeData,
                          color: AppColor.white,
                          withBoxShadow: false,
                          onClick: _onUpdatePassword,
                          leadingIcon: AppMedia.resetPassword,
                          title: AppStrings.resetYourPass.tr,
                          trailingIcon: AppMedia.arrowIos),
                      const SizedBox(height: AppSize.s60),
                      PrimaryButton(
                          textButton: AppStrings.update.tr,
                          colorBtn: logic.isUpdateBtnEnable(
                                  _fullNameController!, _emailController!)
                              ? AppColor.primary
                              : AppColor.grey,
                          colorText: AppColor.white,
                          isLoading: logic.isLoading,
                          //logic.isLoading,
                          onClicked: !logic.isUpdateBtnEnable(
                                  _fullNameController!, _emailController!)
                              ? () {}
                              : () => _onUpdateProfileClick(logic,
                                  _fullNameController!, _emailController!)),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  _onUpdateProfileClick(
    AuthViewModel logic,
    TextEditingController _fullNameController,
    TextEditingController _emailController,
  ) {
    if (_formKey.currentState!.validate() &&
        _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      logic.updateProfile(_fullNameController, _emailController);
    }
  }

  _onUpdatePassword() {
    Get.to(() => const UpdatePasswordView());
  }
}
