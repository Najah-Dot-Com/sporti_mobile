import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:sporti/network/api/feature/privacyPolicy_feature.dart';

import '../../util/sh_util.dart';

class PrivacyPolicyViewModel extends GetxController {
  bool isLoading = false;
  String? privacyDetails = "";
  String? privacyTitle = "";
  String? termsDetails = "";
  String? termsTitle = "";

  @override
  void onInit() {
    super.onInit();
    // getPrivacyAndTermsPages();
  }

  Future<void> getPrivacyAndTermsPages() async {
    try {
      isLoading = true;
      update();
      await PrivacyPolicyFeature.getInstance.getPrivacyPages().then((value) async{
        //check list if not empty do or don't do.
        if (value != null && value.isNotEmpty) {
          //for privacy policy data.
          privacyDetails = value[0].details;
          privacyTitle = value[0].title;
          //for conditions and terms data.
          termsDetails = value[1].details;
          termsTitle = value[1].title;
          await SharedPref.instance.setPolicyAndTermsString(termsTitle:termsTitle, termsDetails:termsDetails, policyTitle:privacyTitle, policyDetails:privacyDetails);
          isLoading = false;
          update();
        }
      }).catchError((e) {
        Logger().d(e.toString());
        isLoading = false;
        update();
      });
    } on Exception catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  // void resetLists() {
  //   privacyPolicyList!.clear();
  //   termsAndConditionsList!.clear();
  //   update();
  // }
}
