import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/home_page_tab.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';

import '../../../viewmodel/auth_viewmodle.dart';

class AccountSuccessVerifyView extends StatelessWidget {
  const AccountSuccessVerifyView({Key? key}) : super(key: key);

  PreferredSizeWidget get myAppbar => AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: myAppbar,
        body: GetBuilder<AuthViewModel>(
            init: AuthViewModel(),
            builder: (logic) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppMedia.doneVerify),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s60,
                  ),
                  CustomTextView(
                    txt: AppStrings.txtVerifyAccountDone.tr,
                    textAlign: TextAlign.center,
                    textStyle: themeData.textTheme.headline1?.copyWith(
                        fontSize: AppFontSize.s24, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: AppSize.s50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s50),
                    child: PrimaryButton(
                        textButton: AppStrings.txtHome.tr,
                        isLoading: logic.isLoading,
                        onClicked: () => _onClicked(logic)),
                  )
                ],
              );
            }));
  }

  _onClicked(AuthViewModel logic) async {
    await logic.goToHomePage();
  }
}
