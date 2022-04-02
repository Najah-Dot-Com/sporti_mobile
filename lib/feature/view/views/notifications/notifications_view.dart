import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/notifications/widget/notification_item.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtNotifications.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        // leading: IconButton(
        //   onPressed: () => Get.back(),
        //   icon: Icon(
        //     Platform.isIOS? Icons.arrow_back_ios:Icons.arrow_back,
        //     color: AppColor.black,
        //   ),
        // ),
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s28),
        child: ListView(
          shrinkWrap: true,
          children: const [
            SizedBox(height: AppSize.s28,),
            NotificationItemWidget(),
            NotificationItemWidget(),
            NotificationItemWidget(),
            NotificationItemWidget(),
            NotificationItemWidget(),
          ],
        ),
      ),
    );
  }
}
