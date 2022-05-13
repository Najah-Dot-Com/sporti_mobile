import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sporti/network/api/dio_manager/dio_manage_class.dart';
import 'app_response.dart';

class NotificationUseCase {
  NotificationUseCase._();
  static final NotificationUseCase getInstance = NotificationUseCase._();
  factory NotificationUseCase() => getInstance;

  Future<AppResponse> allNotifications({var url, var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(header: header, url: url);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      var msg = json.decode(e.response.toString());
      Logger().e(msg);
      return AppResponse.fromJson(msg ?? {});
    }
  }
}
