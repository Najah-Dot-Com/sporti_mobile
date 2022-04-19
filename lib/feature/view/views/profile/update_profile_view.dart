// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/profile/widget/profileItem.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';

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
  final ImagePicker _picker = ImagePicker();
  File? _image;
  var imagePath;
  static var img =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80";
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

  Widget _userCardData(ThemeData themeData, BuildContext context) {
    return Container(
      width: AppSize.s150,
      height: AppSize.s150,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(AppPadding.p18),
              child: imageNetwork(
                  url: img,
                  width: AppSize.s120,
                  height: AppSize.s120,
                  fit: BoxFit.cover)),
          Positioned(
            left: 15,
            bottom: 15,
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
                _showPicker(context);
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
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p100, horizontal: AppPadding.p20),
        child: SingleChildScrollView(
          child: GetBuilder<AuthViewModel>(
              init: AuthViewModel(),
              builder: (logic) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _userCardData(themeData, context),
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
                      onSubmitted: (v) {
                        if (v.isNotEmpty) {
                          hideFocus(context);
                        }
                      },
                    ),
                    const SizedBox(height: AppSize.s60),
                    profileItem(themeData,
                        color: AppColor.lightBlue,
                        withBoxShadow: false,
                        onClick: _onUpdatePassword,
                        leadingIcon: AppMedia.resetPassword,
                        title: AppStrings.resetYourPass.tr,
                        trailingIcon: AppMedia.arrowIos),
                    const SizedBox(height: AppSize.s60),
                    PrimaryButton(
                        textButton: AppStrings.update.tr,
                        colorBtn: AppColor.primary,
                        colorText: AppColor.white,
                        isLoading: logic.isLoading, //logic.isLoading,
                        onClicked: () => _onUpdateProfileClick(logic,
                            _fullNameController!, _emailController!, _image!)),
                  ],
                );
              }),
        ),
      ),
    );
  }

  _onUpdateProfileClick(AuthViewModel logic, TextEditingController _fullNameController,
      TextEditingController _emailController, File image) {
    //TODO:
    if (_fullNameController != null &&
        _emailController != null &&
        image != null) {
      logic.updateProfile(_emailController, _fullNameController, image);
    }
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 40);
    if (image!.length() != 0) {
      // EasyLoading.show(status: '... جاري التحميل'); // show loding indicator
      _image = image as File;
      // EasyLoading.dismiss(); // stop loging indicator
    }
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (image!.length() != 0) {
       _image = image as File;
      //   imagePath = File(image.path);
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(
                      AppStrings.txtGallery.tr,
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(AppStrings.txtCamera.tr, textAlign: TextAlign.right),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  _onUpdatePassword() {
    Get.to(() => const UpdatePasswordView());
  }
}
