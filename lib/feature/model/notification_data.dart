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
        id: json['id'] == null ? null:json['id'],
        notifyType: json[ConstanceNetwork.notifyType] == null ? null:json[ConstanceNetwork.notifyType],
        title: json['title'] == null ? null:json['title'],
        body: json['body'] == null ? null:json['body'],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null:id,
        ConstanceNetwork.notifyType: notifyType == null ? null:notifyType,
        "title": title == null ? null:title,
        "body": body == null ? null:body
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
        pageTotle:json["pageTotle"] == null ? null: json["pageTotle"],
        data:json["data"] == null ? null: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pageTotle": pageTotle == null ? null:pageTotle,
        "data":data == null ? null: List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}
