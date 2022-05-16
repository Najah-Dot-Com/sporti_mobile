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
        id: json['id']??null,
        notifyType: json["notifiy_type"]??null,
        title: json['title']??null,
        body: json['body']??null,
      );

  Map<String, dynamic> toJson() => {
        "id": id??null,
        "notifiy_type": notifyType??null,
        "title": title??null,
        "body": body??null,
      };
}
