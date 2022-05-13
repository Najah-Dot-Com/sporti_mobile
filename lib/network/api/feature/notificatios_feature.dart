import 'package:logger/logger.dart';
import 'package:sporti/feature/model/notification_data.dart';
import 'package:sporti/network/api/model/notification_usecase.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';

class NotificationsFeature {
  NotificationsFeature._();
  static final NotificationsFeature getInstance = NotificationsFeature._();
  factory NotificationsFeature() => getInstance;

  Future<List<NotificationData>?> allNotifications() async {
    var appResponse = await NotificationUseCase.getInstance.allNotifications(
      url: ConstanceNetwork.allNotificationse,
      header: ConstanceNetwork.header(2),
    );
    if (appResponse.status == true) {
      Logger().d("if ", appResponse.toJson());
      List result = appResponse.result;
      List<NotificationData> data =
          result.map((e) => NotificationData.fromJson(e)).toList();
      return data;
    } else {
      Logger().d("else notifications", appResponse.toJson());
      return [];
    }
  }
}
