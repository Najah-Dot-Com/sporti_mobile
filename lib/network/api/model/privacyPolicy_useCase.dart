import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../dio_manager/dio_manage_class.dart';
import 'app_response.dart';

class PrivacyPolicyUseCase {
  PrivacyPolicyUseCase._();
  static final PrivacyPolicyUseCase getInstance = PrivacyPolicyUseCase._();
  factory PrivacyPolicyUseCase() => getInstance;

  Future<AppResponse> getPrivacyPages({var url, var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(header: header, url: url);
      dynamic res = AppResponse.fromJson(json.decode(response.toString()));
      return res;
    } on DioError catch (e) {
      var msg = json.decode(e.response.toString());
      Logger().e(msg);
      return AppResponse.fromJson(msg ?? {});
    }
  }
}
