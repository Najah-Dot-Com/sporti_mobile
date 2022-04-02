import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/customButton.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/sportiTextField.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_strings.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
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
              SportiTextField(
                hint: AppStrings.password.tr,
                isforPass: true,
                 /* controller:  */
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              SportiTextField(
                hint: AppStrings.repassword.tr,
                isforPass: true, 
                /* controller:  */
              ),
              const SizedBox(
                height: AppSize.s100,
              ),
              CustomButton(
                width: double.infinity,
                height: AppSize.s60,
                label: AppStrings.update.tr,
                labelcolor: AppColor.white,
                isRoundedBorder: false,
                primaryColor: AppColor.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
