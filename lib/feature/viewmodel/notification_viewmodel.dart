import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/notification_data.dart';
import 'package:sporti/network/api/feature/notificatios_feature.dart';
import 'package:sporti/network/api/model/exercises_usecase.dart';

import '../../util/app_shaerd_data.dart';

class NotificationViewModel extends GetxController {
  bool isLoading = false;
  List<NotificationData> notificatiosDataList = [];

  @override
  onInit() async {
    super.onInit();
    allNotifications();
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

  Future<void> allNotifications() async {
    try {
      isLoading = true;
      update();
      await NotificationsFeature.getInstance
          .allNotifications()
          .then((value) async {
        if (value != null && value.isNotEmpty) {
          notificatiosDataList.clear();
          notificatiosDataList = value;
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("allNotifications catchError", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d("allNotifications  catch", e.toString());
      isLoading = false;
      update();
    }
  }
}
