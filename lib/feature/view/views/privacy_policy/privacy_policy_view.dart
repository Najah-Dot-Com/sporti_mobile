import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
// import 'package:sporti/util/sh_util.dart';
import '../../../viewmodel/privacyPolicy_viewmodel.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  PrivacyPolicyWidget({Key? key}) : super(key: key);
  // final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(HomeViewModel());
  // final PrivacyPolicyViewModel _privacyAndTerms =
  //     Get.put<PrivacyPolicyViewModel>(PrivacyPolicyViewModel(),
  //         permanent: true);
  // final SharedPref _pref = SharedPref();
  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtPrivacyPolicies.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GetBuilder<PrivacyPolicyViewModel>(
              init: PrivacyPolicyViewModel(),
              initState: (state) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  // state.controller!.getPrivacyAndTermsPages();
                });
              },
              builder: (logic) {
                return 
            Column(
                  children: [
                    ListTile(
                      // title: HtmlWidget(
                      //   "${logic.privacyTitle}",
                      //   // _pref.getPolicyTitle(),
                      //   textStyle: themeData.textTheme.headline1
                      //       ?.copyWith(color: AppColor.black),
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p14, horizontal: AppPadding.p14),
                      subtitle: HtmlWidget(
                        "${logic.privacyDetails}",
                      // _pref.getPolicyDetails(),
                        textStyle: themeData.textTheme.headline2
                            ?.copyWith(color: AppColor.black),
                      ),
                    ),
                  ],
                );
             }
             ),
        ),
      ),
    );
  }
}
