import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';
import 'package:get/get.dart';
import 'package:sporti/util/date_time_util.dart';

import '../../../../model/notification_data.dart';

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({Key? key, this.data}) : super(key: key);
  NotificationData? data;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppSize.s10),
          boxShadow: [AppShadow.boxShadowLight()!]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: CustomTextView(
              txt: data!.title, //AppStrings.txtNotifications.tr,
              textStyle: themeData.textTheme.headline1
                  ?.copyWith(color: AppColor.primary),
            ),
          ),
          Divider(
            color: AppColor.primary,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: CustomTextView(
              txt: data!.body, //AppStrings.txtNotifications.tr,
              textStyle:
                  themeData.textTheme.headline2?.copyWith(color: AppColor.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: CustomTextView(
              txt: DateUtility.dateFormatNamed(date:data!.createdAt!), //AppStrings.txtNotifications.tr,
              textStyle:
                  themeData.textTheme.headline2?.copyWith(color: AppColor.grey , fontSize: AppFontSize.s11),
            ),
          ),
        ],
      ),
    );
  }
}
