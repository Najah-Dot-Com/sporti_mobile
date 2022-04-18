//this for items in the below to go to another pages
  import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../util/app_color.dart';
import '../../../../../util/app_dimen.dart';
import '../../../../../util/app_media.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/localization/localization_service.dart';
import '../../../appwidget/custome_text_view.dart';

Widget profileItem(ThemeData themeData , {bool? withBoxShadow=true,Color? color,required Function() onClick,required String title, required String leadingIcon , required String trailingIcon}) {
    return InkWell(
      onTap: onClick,
      child:
      withBoxShadow ==true?
      Container(
        width: double.infinity,
        height: AppSize.s50,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        margin:const EdgeInsets.only(bottom: AppSize.s12),
        decoration: BoxDecoration(
            color: color??AppColor.white,
            borderRadius: BorderRadius.circular(AppPadding.p8),
            boxShadow: [
              AppShadow.boxShadow()!
            ]
        ),
        child: Row(
          children: [
            SvgPicture.asset(leadingIcon),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: CustomTextView(
                  txt:title,
                  textStyle: themeData.textTheme.headline2),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            if(Get.locale == LocalizationService.localeEn && trailingIcon == AppMedia.arrowIos)...[
              const Icon(Icons.arrow_forward_ios),
            ]else...[
              SvgPicture.asset(trailingIcon)
            ]
          ],
        ),
      ):Container(
        width: double.infinity,
        height: AppSize.s50,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        margin:const EdgeInsets.only(bottom: AppSize.s12),
        decoration: BoxDecoration(
            color: color??AppColor.white,
            //borderRadius: BorderRadius.circular(AppPadding.p8),
            border: Border(
              bottom: BorderSide(
                color: AppColor.black,
                width: 0.5,
              ),
            ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(leadingIcon),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: CustomTextView(
                  txt:title,
                  textStyle: themeData.textTheme.headline2),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            if(Get.locale == LocalizationService.localeEn && trailingIcon == AppMedia.arrowIos)...[
              const Icon(Icons.arrow_forward_ios),
            ]else...[
              SvgPicture.asset(trailingIcon)
            ]
          ],
        ),
      )
    );
  }