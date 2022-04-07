import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sporti/network/api/dio_manager/dio_manage_class.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/sh_util.dart';

import 'app_response.dart';

class ExercisesUseCase{

  ExercisesUseCase._();
  static final ExercisesUseCase getInstance = ExercisesUseCase._();
  factory ExercisesUseCase() => getInstance;



  //todo this is for allExercises request
  Future<AppResponse> allExercises({var url, var header, var body}) async{
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

  //todo this is for allTopExercises request
  Future<AppResponse> allTopExercises({var url, var header, }) async{
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


  //todo this is for addToMyWork request
  Future<AppResponse> addToMyWork({var url, var header, var body}) async{
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

  //todo this is for addEventExercises request
  Future<AppResponse> addEventExercises({var url, var header, var body}) async{
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
}