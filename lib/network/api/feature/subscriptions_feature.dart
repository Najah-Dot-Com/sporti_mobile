import 'package:logger/logger.dart';
import 'package:sporti/feature/model/balance_data.dart';
import 'package:sporti/feature/model/exercise_details_data.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/model/search_exercise_data.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/network/api/feature/auth_feature.dart';
import 'package:sporti/network/api/model/app_response.dart';
import 'package:sporti/network/api/model/auth_usecase.dart';
import 'package:sporti/network/api/model/exercises_usecase.dart';
import 'package:sporti/network/api/model/subscriptions_usecase.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/sh_util.dart';

class SubscriptionsFeature {

  SubscriptionsFeature._();
  static final SubscriptionsFeature getInstance = SubscriptionsFeature._();
  factory SubscriptionsFeature()=> getInstance;


  Future<List<PlanData>?> allSubscriptionsPlan() async{
    var appResponse = await SubscriptionsUseCase.getInstance.allSubscriptionsPlan(
        url: ConstanceNetwork.plans,
        header: ConstanceNetwork.header(2)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");

      List result = appResponse.result;
      List<PlanData> data = result.map((e) => PlanData.fromJson(e)).toList();
      return data;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }


  Future<AppResponse> subscriptionsToPlan(Map<String  ,dynamic> map) async{
    var appResponse = await SubscriptionsUseCase.getInstance.subscriptionsToPlan(
        url: ConstanceNetwork.subscriptions,
        body: map,
        header: ConstanceNetwork.header(1)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      loginAgain();
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }


}
