import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtPrivacyPolicies.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s28),
        children: [
          const SizedBox(
            height: AppSize.s28,
          ),
          CustomTextView(
            txt: "Placholder",
            textStyle:
                themeData.textTheme.headline2?.copyWith(color: AppColor.black),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          CustomTextView(
            txt: "Placholder",
            textStyle:
                themeData.textTheme.headline3?.copyWith(color: AppColor.black),
          ),
        ],
      ),
    );
  }
}
