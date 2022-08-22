import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/localization/localization_service.dart';
import 'package:sporti/util/sh_util.dart';

import '../primary_button.dart';

class SocialBottomSheet extends StatelessWidget {
  const SocialBottomSheet({
    Key? key,
  }) : super(key: key);

//language
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      // height: sizeH300,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(AppSize.s20))),
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSize.s20),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: AppSize.s6,
              width: AppSize.s50,
              decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(AppSize.s6)),
            ),
          ),
          // if (title.toString().isNotEmpty) ...[
          //   SizedBox(height: sizeH25),
          //   CustomTextView(
          //     txt: "$title",
          //     textAlign: TextAlign.center,
          //     textStyle: textStyleTitle(),
          //   ),
          // ],
          const SizedBox(height: AppSize.s24),
          CustomTextView(
            txt: AppStrings.socialMedia.tr,
            textAlign: TextAlign.center,
            textStyle: themeData.textTheme.headline2
                ?.copyWith(color: AppColor.primary),
          ),

          const SizedBox(
            height: AppSize.s28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: _onInstaClick,
                child: Image.asset(
                  AppMedia.instagramIcons,
                  width: AppSize.s50,
                  height: AppSize.s50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: AppSize.s12,
              ),
              InkWell(
                onTap: _onSnapClick,
                child: Image.asset(
                  AppMedia.snapchatIcons,
                  width: AppSize.s50,
                  height: AppSize.s50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSize.s40,
          )
        ],
      ),
    );
  }



  void _onInstaClick() async{
    await openBrowser("https://instagram.com/hi_conception?igshid=YmMyMTA2M2Y=");
  }

  void _onSnapClick() async{
    await openBrowser("https://www.snapchat.com/add/njhkwm?share_id=svgZbMVieyI&locale=en-US"/*https://www.snapchat.com/add/najahdot?share_id=CKjFxKSlJMM&locale=en-KW*/);
  }
}
