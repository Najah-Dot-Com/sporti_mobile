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

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
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
      body: Padding(
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
                SportiTextField(
                  hint: AppStrings.email.tr,
                  isforPass: false,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: AppSize.s100,
                ),
                CustomButton(
                  width: double.infinity,
                  height: AppSize.s60,
                  label: AppStrings.verify.tr,
                  labelcolor: AppColor.white,
                  isRoundedBorder: false,
                  primaryColor: AppColor.primary,
                  onTap: _onVerifyClick,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onVerifyClick() {
    Get.to(ResetPasswordView());
  }
}
