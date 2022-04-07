import 'package:logger/logger.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/network/api/model/app_response.dart';
import 'package:sporti/network/api/model/auth_usecase.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class AuthFeature {

  AuthFeature._();
  static final AuthFeature getInstance = AuthFeature._();
  factory AuthFeature()=> getInstance;



  Future<UserData> signUpUser(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.signUpRequest(body:
    body,
        url: ConstanceNetwork.signUpApi,
        header: ConstanceNetwork.header(3)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result??{});
    } else {
      snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result??{});
    }
  }


  Future<UserData> loginUser(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.loginRequest(body:
    body,
        url: ConstanceNetwork.loginApi,
        header: ConstanceNetwork.header(3)
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result??{});
    } else {
      snackError("",  appResponse.message??""/*ConstanceNetwork.getErrorStatusCode(appResponse.statusCode)*/);
      Logger().d("else ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result??{});
    }
  }

  Future<AppResponse> logoutUser() async {
    var appResponse = await AuthUseCase.getInstance.logoutRequest(
        url: ConstanceNetwork.logoutApi,
        header: ConstanceNetwork.header(2)
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

  Future<AppResponse> resetUserPassword(Map<String, dynamic> body) async{
    var appResponse = await AuthUseCase.getInstance.resetUserPassword(
        body:body,
        url: ConstanceNetwork.changePasswordApi,
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

}