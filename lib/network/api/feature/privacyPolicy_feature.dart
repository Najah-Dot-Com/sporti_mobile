import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:sporti/network/api/model/app_response.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import '../../../feature/model/PolicyAndTerms.dart';
import '../model/privacyPolicy_useCase.dart';

class PrivacyPolicyFeature {
  PrivacyPolicyFeature._();
  static final PrivacyPolicyFeature getInstance = PrivacyPolicyFeature._();
  factory PrivacyPolicyFeature() => getInstance;

  Future<List<Result>?> getPrivacyPages() async {
    var appResponse = await PrivacyPolicyUseCase.getInstance.getPrivacyPages(
      url: ConstanceNetwork.getPages,
      header: ConstanceNetwork.header(0),
    );
    if (appResponse.status == true) {
      List result = appResponse.result;
      List<Result> data = result.map((e) => Result.fromJson(e)).toList();
      return data;
    } else {
      Logger().d("else getPrivacyPolicy pages feature", appResponse.toJson());
      return jsonDecode(appResponse.result);
    }
  }
}
