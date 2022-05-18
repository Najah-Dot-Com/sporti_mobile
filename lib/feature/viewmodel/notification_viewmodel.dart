import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/notification_data.dart';
import 'package:sporti/network/api/feature/notificatios_feature.dart';
import 'package:sporti/network/api/model/exercises_usecase.dart';

import '../../util/app_shaerd_data.dart';

class NotificationViewModel extends GetxController {
  bool isLoading = false;
  bool isLoadingMore = false;
  List<NotificationData> notificatiosDataList = [];
  int? page = 1;
  int? pageTotal = 0;

  @override
  onInit() async {
    super.onInit();
    page = 1;
    notificatiosDataList = [];
    await getAllNotifications(page);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getAllNotifications(var page) async {
    try {
      if (notificatiosDataList.isEmpty) {
        isLoading = true;
      } else {
        isLoadingMore = true;
      }
      update();
      await NotificationsFeature.getInstance
          .allNotifications(page)
          .then((value) async {
        if (value.data != null && value.data!.toList().isNotEmpty) {
          // notificatiosDataList = value.data!.toList();
          for(var item in value.data!.toList()){
            if(!notificatiosDataList.contains(item)){
              notificatiosDataList.add(item);
            }
          }
          // notificatiosDataList.addAll(value.data!.toList());
          pageTotal = value.pageTotle;
          isLoading = false;
          isLoadingMore = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        // snackError("getAllNotifications model catchError", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        isLoadingMore = false;
        update();
      });
    } catch (e) {
      Logger().d("getAllNotifications model  catch", e.toString());
      isLoading = false;
      isLoadingMore = false;
      update();
    }
  }



  Future loadMoreNotifications() async {
    isLoadingMore = true;
    update();
    if (page! <= pageTotal!) {
      page = page! + 1;
      // await getAllAnnouncement(
      //     pageIndexAllAnnouncement, pageSizeAllAnnouncement, "",
      //     isPagination: true);
      await getAllNotifications(page);
      await  Future.delayed(const Duration(seconds: 0));
    }
    isLoadingMore = false;
    update();
  }
}
