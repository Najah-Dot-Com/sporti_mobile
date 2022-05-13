import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/notifications/widget/notification_item.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';

import '../../../viewmodel/notification_viewmodel.dart';
import '../categoriy_exercise_details/widget/page_shimmer_widget.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);
  // final NotificationViewModel _notificationViewModel =
  //     Get.put(NotificationViewModel());
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
      body: GetBuilder<NotificationViewModel>(
          init: NotificationViewModel(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.allNotifications();
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return const PageShimmerWidget();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p16,horizontal: AppPadding.p16),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s10,
                ),
                itemCount: logic.notificatiosDataList.length,
                itemBuilder: (context, index) => NotificationItemWidget(
                    data: logic.notificatiosDataList[index]),
                shrinkWrap: true,
              ),
            );
          }),
    );
  }
}
