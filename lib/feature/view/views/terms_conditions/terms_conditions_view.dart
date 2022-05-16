import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

import '../../../viewmodel/privacyPolicy_viewmodel.dart';

class TermsConditionView extends StatelessWidget {
  TermsConditionView({Key? key}) : super(key: key);
  final PrivacyPolicyViewModel _privacyAndTerms =
      Get.put<PrivacyPolicyViewModel>(PrivacyPolicyViewModel(),
          permanent: true);
  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtTermsAndConditions.tr,
          textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.black),
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
                  state.controller!.getPrivacyAndTermsPages();
                });
              },
              builder: (context) {
                return Column(
                  children: [
                    ListTile(
                      title: HtmlWidget(
                        "${_privacyAndTerms.termsTitle}",
                        textStyle: themeData.textTheme.headline1
                            ?.copyWith(color: AppColor.black),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p14, horizontal: AppPadding.p14),
                      subtitle: HtmlWidget(
                        "${_privacyAndTerms.termsDetails}",
                        textStyle: themeData.textTheme.headline2
                            ?.copyWith(color: AppColor.black),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
