import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';

class HomePageTab extends StatelessWidget {
  const HomePageTab({Key? key}) : super(key: key);

  static final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(HomeViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData) => AppBar(
        centerTitle: false,
        title: CustomTextView(
          txt: AppStrings.txtHello.tr + " Osama ",
          textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        actions: [
          MaterialButton(
            onPressed: _onNotificationClick,
            minWidth: AppSize.s48,
            child: Icon(
              Icons.notifications_rounded, //feed_outlined
              size: AppSize.s24,
              color: AppColor.grey,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(themeData),
      body: const SizedBox(),
    );
  }

  void _onNotificationClick() {
    _homeViewModel.onTabChange(_homeViewModel.notificationsIndex);
  }
}
