import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_color.dart';
import '../../../util/app_shaerd_data.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import 'custome_text_view.dart';

class WellcomeRow extends StatelessWidget {
  const WellcomeRow({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this for login "welcome" and "choose language" text.
    var themeData = Theme.of(context);
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          //  GestureDetector(
          //    onTap:() => simplePopup(firstLable: 'Ar', secondLabel: 'En'),
          //    child: Text(
              // AppStrings.chooseLanguage,
              // style:
              //     AppTextStyle.getBoldStyle(color: Colors.white, fontSize: 16.0),
              // ),
          //  ),
        Builder(
          builder: (context) {
            return TextButton(
              onPressed: ()=>simplePopup(context: context,firstLable: 'Ar', secondLabel: 'En'),
              child:
              CustomTextView(txt: AppStrings.chooseLanguage.tr,textStyle: themeData.textTheme.headline1?.copyWith(color: AppColor.white),),
              );
          }
        ),
        CustomTextView(txt: AppStrings.hello.tr,textStyle: themeData.textTheme.headline4?.copyWith(color: AppColor.white),),
      ],
    ));
  }
}
