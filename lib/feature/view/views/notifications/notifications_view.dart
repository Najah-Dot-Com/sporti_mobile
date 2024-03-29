import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/fcm/app_fcm.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/shimmer_your_work_widget.dart';
import 'package:sporti/feature/view/views/notifications/widget/notification_item.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import '../../../viewmodel/notification_viewmodel.dart';
import '../categoriy_exercise_details/widget/page_shimmer_widget.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);

  final NotificationViewModel _notificationViewModel =
      Get.put(NotificationViewModel());
  ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   // _notificationViewModel = Get.put(NotificationViewModel());
  //   // _notificationViewModel.notificatiosDataList.clear();
  //   // scrollController = ScrollController();
  //   _notificationViewModel.onInit();
  //   scrollController.addListener(scrollUp);
  // }

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtNotifications.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Platform.isIOS? Icons.arrow_back_ios:Icons.arrow_back,
            color: AppColor.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      body: GetBuilder<NotificationViewModel>(
          init: NotificationViewModel(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              scrollController.addListener(state.controller!.loadMoreNotifications);
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return Column(
                children:const [
                   ShimmerSelectYourWorkWidget(),
                   ShimmerSelectYourWorkWidget(),
                   ShimmerSelectYourWorkWidget(),
                   ShimmerSelectYourWorkWidget(),
                   ShimmerSelectYourWorkWidget(),
                   ShimmerSelectYourWorkWidget(),
                ],
              );
            }else if(!logic.isLoading && logic.notificatiosDataList.isEmpty){
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image.asset(AppMedia.emptyState,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16, horizontal: AppPadding.p16),
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [

                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.separated(
                          controller: scrollController,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: AppSize.s10,
                          ),
                          itemCount: logic.notificatiosDataList.toList().length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              onClickNotifyItem(logic: logic, index: index);
                            },
                            child: NotificationItemWidget(
                                data: logic.notificatiosDataList
                                    .toList()[index]),
                          ),
                        ),
                      ),
                    ),
                    (logic.isLoadingMore)
                        ? SizedBox(
                        width: width,
                        height: 120,
                        child: const PageShimmerWidget())
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  // void scrollUp() async {
  //   try {
  //     if (scrollController.offset <= scrollController.position.minScrollExtent && !scrollController.position.outOfRange) {
  //       if (_notificationViewModel.page != _notificationViewModel.pageTotal &&
  //           _notificationViewModel.page++ <=
  //               _notificationViewModel.pageTotal!) {
  //         _notificationViewModel.page = _notificationViewModel.page++;
  //         _notificationViewModel.update();
  //         await _notificationViewModel
  //             .getAllNotifications(_notificationViewModel.page);
  //       }
  //
  //     }
  //   } on Exception catch (e) {
  //     Logger().d("getAllNotifications(page)", e);
  //   }
  // }

  onClickNotifyItem({NotificationViewModel? logic, int? index}) {
    try {
      logic!.isLoading = true;
      AppFcm.goToOrderPage(logic.notificatiosDataList.toList()[index!].toJson());
      logic.isLoading = false;
    } on Exception catch (e) {
      Logger().d(" AppFcm.goToOrderPage :", e.toString());
    }
  }

  Future<void> _onRefresh() async{
    _notificationViewModel.notificatiosDataList.clear();
    _notificationViewModel.page = 0;
    await _notificationViewModel.getAllNotifications(0);
    await Future.delayed(const Duration(seconds: 1));
  }
}
