import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/newly_item_widget.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/shimmer_newly_item_widget.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';

import 'widget_home_tab/selecte_your_work_widget.dart';
import 'widget_home_tab/shimmer_your_work_widget.dart';

class HomePageTab extends StatelessWidget {
  const HomePageTab({Key? key}) : super(key: key);

  static final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(
      HomeViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData) =>
      AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: CustomTextView(
          txt: AppStrings.txtHello.tr + " ${SharedPref.instance
              .getUserData()
              .fullname} ",
          textStyle: themeData.textTheme.headline2?.copyWith(
              color: AppColor.black),
        ),
        actions: [
          MaterialButton(
            onPressed: _onNotificationIconClick,
            minWidth: AppSize.s48,
            child: Icon(
              Icons.notifications_rounded, //feed_outlined
              size: AppSize.s24,
              color: AppColor.grey,
            ),
          ),
        ],
      );

  Widget  newlyAdePackage(HomeViewModel logic) {
    if(logic.isLoading){
      return SizedBox(
        height: AppSize.s140,
        child: ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.horizontal,
          physics: AppStyleScroll.customScrollViewIOS(),
          itemBuilder: (context, index) {
            return const ShimmerNewlyItemWidget();
          },
        ),
      );
    }else if(!logic.isLoading && logic.exercisesListRecentlyAll.isEmpty){
      //todo:// here we will add empty state widget
      return const SizedBox.shrink();
    }
    return SizedBox(
        height: AppSize.s140,
        child: ListView.builder(
          itemCount: logic.exercisesListRecentlyAll.length,
          shrinkWrap: true,
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.horizontal,
          physics: AppStyleScroll.customScrollViewIOS(),
          itemBuilder: (context, index) {
            return  NewlyItemWidget(packages: logic.exercisesListRecentlyAll[index]);
          },
        ),
      );
  }

  Widget  selectMyWorkWidget(HomeViewModel logic) {
    if(logic.isLoading){
      return ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const ShimmerSelectYourWorkWidget();
          });

    }else if(!logic.isLoading && logic.exercisesListAll.isEmpty){
      //todo:// here we will add empty state widget
      return const SizedBox.shrink();
    }
    return ListView.builder(
          itemCount: logic.exercisesListAll.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return  SelectYourWorkWidget(package:logic.exercisesListAll[index]);
          });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(themeData),
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          initState: (state){
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.allPackagesExercises();
              state.controller?.allPackagesTopExercises();
            });
          },
          builder: (logic) {
        return SingleChildScrollView(
          physics: AppStyleScroll.customScrollViewIOS(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSize.s28,),
                CustomTextView(
                  txt: AppStrings.txtNewlyAddedPackages.tr,
                  textStyle: themeData.textTheme.headline2?.copyWith(
                      color: AppColor.black),
                ),
                const SizedBox(height: AppSize.s28,),
                newlyAdePackage(logic),
                const SizedBox(height: AppSize.s20,),
                CustomTextView(
                  txt: AppStrings.txtChooseYourFavoriteExercises.tr,
                  textStyle: themeData.textTheme.headline2?.copyWith(
                      color: AppColor.black),
                ),
                const SizedBox(height: AppSize.s20,),
                selectMyWorkWidget(logic),

              ],
            ),
          ),
        );
      }),
    );
  }

  void _onNotificationIconClick() {
    _homeViewModel.onTabChange(_homeViewModel.notificationsIndex);
  }
}
