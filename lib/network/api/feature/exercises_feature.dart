import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/network/api/model/app_response.dart';
import 'package:sporti/network/api/model/auth_usecase.dart';
import 'package:sporti/network/api/model/exercises_usecase.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class ExercisesFeature {

  ExercisesFeature._();
  static final ExercisesFeature getInstance = ExercisesFeature._();
  factory ExercisesFeature()=> getInstance;


  Future<List<ExercisesData>?> allExercises(Map<String, dynamic> body) async{
    var appResponse = await ExercisesUseCase.getInstance.allExercises(
        body:body,
        url: ConstanceNetwork.exercisesApi,
        header: ConstanceNetwork.header(1)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      List result = appResponse.result;
      List<ExercisesData> data = result.map((e) => ExercisesData.fromJson(e)).toList();
      return data;
    } else {
      snackError("",  appResponse.message??appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }

  Future<List<ExercisesData>?> allTopExercises() async{
    var appResponse = await ExercisesUseCase.getInstance.allTopExercises(
        url: ConstanceNetwork.topExercisesApi,
        header: ConstanceNetwork.header(1)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      List result = appResponse.result;
      List<ExercisesData> data = result.map((e) => ExercisesData.fromJson(e)).toList();
      return data;
    } else {
      snackError("",  appResponse.message??appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }


  Future<AppResponse> addToMyWork(Map<String, dynamic> body) async{
    var appResponse = await ExercisesUseCase.getInstance.addToMyWork(
        body:body,
        url: ConstanceNetwork.isFavoriteApi,
        header: ConstanceNetwork.header(1)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      snackError("",  appResponse.message??appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }
}
