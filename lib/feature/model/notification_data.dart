import 'package:flutter/foundation.dart';

import '../../network/utils/constance_netwoek.dart';

class NotificationData {
  dynamic id;
  String? notifyType;
  String? title;
  String? body;
  NotificationData({this.id, this.notifyType, this.title, this.body});
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json['id'],
        notifyType: json[ConstanceNetwork.notifyType],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        ConstanceNetwork.notifyType: notifyType,
        "title": title,
        "body": body
      };
}
