import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sporti/network/api/dio_manager/dio_manage_class.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/sh_util.dart';
import 'app_response.dart';

class SubscriptionsUseCase {
  SubscriptionsUseCase._();

  static final SubscriptionsUseCase getInstance = SubscriptionsUseCase._();

  factory SubscriptionsUseCase() => getInstance;

  //todo this is for allSubscriptionsPlan request
  Future<AppResponse> allSubscriptionsPlan({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header, queryParameters: body);
      SharedPref.instance.setAllSubscriptions(json.encode(json.decode(response.toString())[ConstanceNetwork.resultKey]));
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message ?? {});
    }
  }

  Future<AppResponse> subscriptionsToPlan({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message ?? {});
    }
  }
}
