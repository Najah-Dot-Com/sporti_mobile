import 'package:logger/logger.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/network/api/model/app_response.dart';
import 'package:sporti/network/api/model/auth_usecase.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class AuthFeature {
  AuthFeature._();
  static final AuthFeature getInstance = AuthFeature._();
  factory AuthFeature() => getInstance;

  Future<UserData> signUpUser(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.signUpRequest(
        body: body,
        url: ConstanceNetwork.signUpApi,
        header: ConstanceNetwork.header(3));
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result ?? {});
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result ?? {});
    }
  }

  Future<UserData> loginUser(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.loginRequest(
        body: body,
        url: ConstanceNetwork.loginApi,
        header: ConstanceNetwork.header(3));
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result ?? {});
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return UserData.fromJson(appResponse.result ?? {});
    }
  }

  Future<AppResponse> logoutUser() async {
    var appResponse = await AuthUseCase.getInstance.logoutRequest(
        url: ConstanceNetwork.logoutApi, header: ConstanceNetwork.header(5));
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> resetUserPassword(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.resetUserPassword(
        body: body,
        url: ConstanceNetwork.changePasswordApi,
        header: ConstanceNetwork.header(1));
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> verifyUserEmail(var parameters) async {
    var appResponse = await AuthUseCase.getInstance.verifyUserEmail(
      url: ConstanceNetwork.verifyEmailApi + parameters,
      // "https://sportiapp.com/api/v1/verifi_email?email=$parameters",
      header: ConstanceNetwork.header(5),
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> confirmEmail(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.confirmUserEmail(
      url: ConstanceNetwork.confirmEmailApi,
      header: ConstanceNetwork.header(5),
      body: body,
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> verifyAccount(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.verifyAccount(
      url: ConstanceNetwork.verifyAccount,
      header: ConstanceNetwork.header(2),
      body: body,
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> confirmAccount(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.confirmUserAccount(
      url: ConstanceNetwork.confirmAccount,
      header: ConstanceNetwork.header(2),
      body: body,
    );
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> deleteUserAccount() async {
    var appResponse = await AuthUseCase.getInstance.deleteUserAccount(
        url: ConstanceNetwork.deleteUserApi,
        header: ConstanceNetwork.header(5));
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> updateProfile(Map<String, dynamic> body) async {
    var appResponse = await AuthUseCase.getInstance.updateProfile(
        body: body,
        url: ConstanceNetwork.updateProfile,
        header: ConstanceNetwork.header(2));
    if (appResponse.status == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }
}
