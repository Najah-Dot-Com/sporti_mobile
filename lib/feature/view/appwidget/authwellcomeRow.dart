import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_color.dart';
import '../../../util/app_shaerd_data.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import 'bottom_sheet/language_bottom_sheet.dart';
import 'custome_text_view.dart';

class WelcomeRow extends StatelessWidget {
  const WelcomeRow({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this for login "welcome" and "choose language" text.
    var themeData = Theme.of(context);
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.bottomSheet(const LanguageBottomSheet());
          },
          child:
          CustomTextView(txt: AppStrings.chooseLanguage.tr,textStyle: themeData.textTheme.headline1?.copyWith(color: AppColor.white),),
        ),
        CustomTextView(txt: AppStrings.hello.tr,textStyle: themeData.textTheme.headline4?.copyWith(color: AppColor.white),),
      ],
    ));
  }
}
