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
class Result {
    Result({
        this.pageTotle,
        this.data,
    });

    int? pageTotle;
    List<NotificationData>? data;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        pageTotle: json["pageTotle"],
        data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pageTotle": pageTotle,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}
