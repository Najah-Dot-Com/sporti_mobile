// ignore_for_file: avoid_print

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'dart:async';

import 'package:logger/logger.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/sh_util.dart';

class DioManagerClass {
  DioManagerClass._();

  static final DioManagerClass getInstance = DioManagerClass._();

  factory DioManagerClass() => getInstance;
  Dio? _dio;

  Dio init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ConstanceNetwork.baseUrl,
        connectTimeout: 2000 * 60,
        receiveTimeout: 2000 * 60,
        sendTimeout: 2000 * 60,
        receiveDataWhenStatusError: true,
      ),
    );
    _dio?.interceptors.add(ApiInterceptors());
    return _dio!;
  }

  Future<Response> dioGetMethod({var url, Map<String, dynamic>? header, var queryParameters}) async {
    if (await checkInternetConnectivity()) {
      return await _dio!.get(url,
          options: Options(headers: header),
          queryParameters: queryParameters ?? {});
    } else {
      throw SocketException(AppStrings.txtConnection.tr.toString());
    }
  }

  Future<Response> dioPostMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    if (await checkInternetConnectivity()) {
      return await _dio!.post(
        url,
        options: Options(headers: header),
        data: body,
      );
    } else {
      throw SocketException(AppStrings.txtConnection.tr.toString());
    }
  }

  Future<Response> dioPostFormMethod(
      {var url, Map<String, dynamic>? header, var body}) async {
    if (await checkInternetConnectivity()) {
      return await _dio!.post(
        url,
        options: Options(headers: header),
        data: FormData.fromMap(body),
      );
    } else {
      throw SocketException(AppStrings.txtConnection.tr.toString());
    }
  }

  Future<Response> dioUpdateMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    print("msg_request_url : $url");
    print("msg_request_header : $header");
    print("msg_request_body : $body");
    if (await checkInternetConnectivity()) {
      return await _dio!
          .put(url, options: Options(headers: header), data: body);
    } else {
      throw SocketException(AppStrings.txtConnection.tr.toString());
    }
  }

  Future<Response> dioDeleteMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    print("msg_request_url : $url");
    print("msg_request_header : $header");
    print("msg_request_body : $body");
    if (await checkInternetConnectivity()) {
      return await _dio!
          .delete(url, options: Options(headers: header), data: body);
    } else {
      throw SocketException(AppStrings.txtConnection.tr.toString());
    }
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    Logger().d(
        "onRequest : ${options.path} \n ${options.data} \n ${options.method}");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    Logger().w("onResponse : ${response.statusCode}");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    Logger().d("onError : ${err.message}");
    if (err.message.contains("401")) {
      SharedPref.instance.setUserLogin(false);
      getx.Get.offAll(LoginView());
      return;
    }
    if(err.message.contains("SocketException")){
      // getx.Get.offAll(LoginView());
      snackError("",AppStrings.txtConnection.tr.toString().replaceAll("SocketException", ""));
    }
  }
}
