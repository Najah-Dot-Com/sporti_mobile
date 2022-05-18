import 'package:logger/logger.dart';
import 'package:sporti/feature/model/notification_data.dart';
import 'package:sporti/network/api/model/notification_usecase.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';

class NotificationsFeature {
  NotificationsFeature._();
  static final NotificationsFeature getInstance = NotificationsFeature._();
  factory NotificationsFeature() => getInstance;

  Future<Result> allNotifications(var page) async {
    var appResponse = await NotificationUseCase.getInstance.allNotifications(
        url: ConstanceNetwork.allNotificationse+"?page=$page",
        header: ConstanceNetwork.header(2),
        page: page);
    if (appResponse.status == true) {
      Logger().d("if ", appResponse.toJson());
      var result = appResponse.result;
      Result data = Result.fromJson(result);
      // result.map((e) => NotificationData.fromJson(e)).toList();
      return data;
    } else {
      Logger().d("else notifications", appResponse.toJson());
      return Result.fromJson(appResponse.toJson());
    }
  }
}
