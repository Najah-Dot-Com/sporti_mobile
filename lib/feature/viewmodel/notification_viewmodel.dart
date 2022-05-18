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
  int page = 1;
  int? pagetotal = 2;

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
      // if (page == this.page&&page++ < pagetotal) {
      //   page++;
      // }
      // update();
      await NotificationsFeature.getInstance
          .allNotifications(page)
          .then((value) async {
        if (value.data!.toList().isNotEmpty) {
          Logger().d("value.data!.toList()", value.data!.toList());
          // notificatiosDataList = value.data!.toList();
          notificatiosDataList.addAll(value.data!.toList());
          pagetotal = value.pageTotle;
          print("notificatiosDataList pagetotal : " "$pagetotal");
          print("notificatiosDataList.length");
          print(notificatiosDataList.length);
          isLoading = false;
          isLoadingMore = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("getAllNotifications model catchError", onError.toString());
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
}
