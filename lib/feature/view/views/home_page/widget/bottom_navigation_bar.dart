import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/icon_nav_bar.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GetBuilder<HomeViewModel>(builder: (logic) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppSize.s30),
            topLeft: Radius.circular(AppSize.s30)),
        child: BottomAppBar(
          elevation: AppSize.s20,
          color: AppColor.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: AppSize.s12,
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconNavBar(
                          title: AppStrings.txtProfile.tr,
                          icon: Icons.person,
                          color: logic.tabControllerIndex == 3
                              ? AppColor.primary
                              : AppColor.grey,
                          onIconClick: () => _onProfileClick(logic)),
                      const SizedBox(height: AppSize.s10,),
                      IconNavBar(
                          title:AppStrings.txtForum.tr/*AppStrings.txtNotifications.tr*/,
                          icon: Icons.public,
                          color: logic.tabControllerIndex == 2
                              ? AppColor.primary
                              : AppColor.grey,
                          onIconClick: () => _onNotificationClick(logic)),
                    ],
                  ),
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconNavBar(
                          title: AppStrings.txtMyWork.tr,
                          icon: Icons.list_alt_rounded,
                          color: logic.tabControllerIndex == 1
                              ? AppColor.primary
                              : AppColor.grey,
                          onIconClick: () => _onMyWorkClick(logic)),
                      const SizedBox(height: AppSize.s10,),
                      IconNavBar(
                          title: AppStrings.txtHome.tr,
                          icon: Icons.home_filled,
                          color: logic.tabControllerIndex == 0
                              ? AppColor.primary
                              : AppColor.grey,
                          onIconClick: () => _onHomePageClick(logic)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  _onProfileClick(HomeViewModel logic) {
    logic.onTabChange(3);
  }

  _onNotificationClick(HomeViewModel logic) {
    logic.onTabChange(2);
  }

  _onMyWorkClick(HomeViewModel logic) {
    logic.onTabChange(1);
  }

  _onHomePageClick(HomeViewModel logic) {
    logic.onTabChange(0);
  }
}
