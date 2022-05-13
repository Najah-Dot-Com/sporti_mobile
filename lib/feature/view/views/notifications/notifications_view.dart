import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/fcm/app_fcm.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/notifications/widget/notification_item.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
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
              state.controller?.getAllNotifications();
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return const PageShimmerWidget();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16, horizontal: AppPadding.p16),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s10,
                ),
                itemCount: logic.notificatiosDataList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    onClickNotifyItem(logic: logic, index: index);
                  },
                  child: NotificationItemWidget(
                      data: logic.notificatiosDataList[index]),
                ),
                shrinkWrap: true,
              ),
            );
          }),
    );
  }

  onClickNotifyItem({NotificationViewModel? logic, int? index}) {
    try {
      logic!.isLoading = true;
      AppFcm.goToOrderPage(logic.notificatiosDataList[index!].toJson());
      logic.isLoading = false;
    } on Exception catch (e) {
      Logger().d(" AppFcm.goToOrderPage :", e.toString());
    }
  }
}
