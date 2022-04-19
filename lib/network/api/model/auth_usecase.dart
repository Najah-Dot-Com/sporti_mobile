import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sporti/network/api/dio_manager/dio_manage_class.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/sh_util.dart';

import 'app_response.dart';

class AuthUseCase{

  AuthUseCase._();
  static final AuthUseCase getInstance = AuthUseCase._();
  factory AuthUseCase() => getInstance;


  //todo this is for signup request
  Future<AppResponse> signUpRequest({var url, var header, var body}) async{
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, body: body, header: header);
      if( json.decode(response.toString())[ConstanceNetwork.resultKey]!= null){
        await SharedPref.instance.setUserData(json.encode(json.decode(response.toString())[ConstanceNetwork.resultKey]));
      }
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }

  //todo this is for login request
  Future<AppResponse> loginRequest({var url, var header, var body}) async{
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, body: body, header: header);
      if( json.decode(response.toString())[ConstanceNetwork.resultKey]!= null){
         await SharedPref.instance.setUserData(json.encode(json.decode(response.toString())[ConstanceNetwork.resultKey]));
      }
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }

  //todo this is for login request
  Future<AppResponse> logoutRequest({var url, var header, var body}) async{
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }

  Future<AppResponse> resetUserPassword({var body, var url, var header}) async{
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header , body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }
  Future<AppResponse> verifyUserEmail({var url, var header,}) async{
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header ,);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }
  Future<AppResponse> confirmUserEmail({var url, var header,var body}) async{
    try{
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    }on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }
  Future<AppResponse> verifyAccount({var url, var header,var body}) async{
    try{
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    }on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }
  Future<AppResponse> confirmUserAccount({var url, var header,var body}) async{
    try{
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header,body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    }on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }

  Future<AppResponse> deleteUserAccount({var url, var header,}) async{
    try{
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header,);
      return AppResponse.fromJson(json.decode(response.toString()));
    }on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }
  //todo this is for updateProfile request
  Future<AppResponse> updateProfile({var url, var header, var body}) async{
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, body: body, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message??{});
    }
  }
}