// ignore_for_file: prefer_if_null_operators

import 'package:get/utils.dart';
import 'package:logger/logger.dart';

class AppResponse {
  dynamic statusCode;
  dynamic result;
  dynamic message;
  dynamic status;

  AppResponse({this.statusCode, this.result, this.message, this.status});

  factory AppResponse.fromJson(var map) {
    try {
      return AppResponse(
        statusCode: map["StatusCode"] == null ? 0 : map["StatusCode"],
        result: map["Result"] == null ? null : map["Result"],
        message: map["Message"] == null ? null : map["Message"],
        status: map["Status"] == null ? null : map["Status"],
      );
    } catch (e) {
      return AppResponse(
          statusCode: 0, result: null, message: "", status: false);
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "StatusCode": statusCode  == null ? null:statusCode,
        "Result": result  == null ? null:result,
        "Message": message  == null ? null:message,
        "Status": status  == null ? null:status
      };
    } catch (e) {
      Logger().e(e);
      return {"": ""};
    }
  }
}
