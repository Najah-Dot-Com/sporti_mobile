import 'package:logger/logger.dart';
import 'package:sporti/feature/model/balance_data.dart';
import 'package:sporti/feature/model/exercise_details_data.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/model/search_exercise_data.dart';
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
      //snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
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
      // snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
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
      snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> addEventExercises(Map<String, dynamic> body) async{
    var appResponse = await ExercisesUseCase.getInstance.addEventExercises(
        body:body,
        url: ConstanceNetwork.eventExercisesApi,
        header: ConstanceNetwork.header(1)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }


  Future<List<ExercisesData>?> getFavoriteExercises() async{
    var appResponse = await ExercisesUseCase.getInstance.getFavoriteExercises(
        url: ConstanceNetwork.favoriteExercisesApi,
        header: ConstanceNetwork.header(2)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      List result = appResponse.result;
      List<ExercisesData> data = result.map((e) => ExercisesData.fromJson(e)).toList();
      return data;
    } else {
      snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }

  Future<BalanceData?> getBalanceUser() async{
    var appResponse = await ExercisesUseCase.getInstance.getBalanceUserApi(
        url: ConstanceNetwork.balanceUserApi,
        header: ConstanceNetwork.header(2)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return BalanceData.fromJson(appResponse.result??{});
    } else {
      // snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return BalanceData.fromJson({});
    }
  }


  Future<ExerciseDetailsData?> getDetailsExercisesApi(var id) async{
    var appResponse = await ExercisesUseCase.getInstance.getDetailsExercisesApi(
        url: ConstanceNetwork.detailsExercisesApi+id.toString(),
        header: ConstanceNetwork.header(2)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return ExerciseDetailsData.fromJson(appResponse.result??{});
    } else {
      // snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return ExerciseDetailsData.fromJson({});
    }
  }

  Future<SearchExerciseData?>  searchExercise(String searchWord) async{
    var appResponse = await ExercisesUseCase.getInstance.searchExercise(
        url: ConstanceNetwork.searchExercisesApi+searchWord.toString(),
        header: ConstanceNetwork.header(2)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return SearchExerciseData.fromJson(appResponse.result??{});
    } else {
      // snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return SearchExerciseData.fromJson({});
    }
  }

}
