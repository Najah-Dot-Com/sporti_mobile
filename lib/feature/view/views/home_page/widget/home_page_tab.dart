import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/newly_item_widget.dart';
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

import 'widget_home_tab/selecte_your_work_widget.dart';

class HomePageTab extends StatelessWidget {
  const HomePageTab({Key? key}) : super(key: key);

  static final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(HomeViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData) => AppBar(
    automaticallyImplyLeading: true,
        centerTitle: false,
        title: CustomTextView(
          txt: AppStrings.txtHello.tr + " Osama ",
          textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.black),
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

  Widget get newlyAdePackage => SizedBox(
    height: AppSize.s140,
    child: ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      clipBehavior: Clip.hardEdge,
      scrollDirection: Axis.horizontal,
      physics: AppStyleScroll.customScrollViewIOS(),
      itemBuilder: (context , index) {
        return const NewlyItemWidget();
      },
    ),
  );

  Widget get selectMyWorkWidget => ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemBuilder: (context , index){
        return const SelectYourWorkWidget();
      });

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(themeData),
      body: SingleChildScrollView(
        physics: AppStyleScroll.customScrollViewIOS(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s28,),
              CustomTextView(
                txt: AppStrings.txtNewlyAddedPackages.tr ,
                textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.black),
              ),
              const SizedBox(height: AppSize.s28,),
              newlyAdePackage,
              const SizedBox(height: AppSize.s20,),
              CustomTextView(
                txt: AppStrings.txtChooseYourFavoriteExercises.tr ,
                textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.black),
              ),
              const SizedBox(height: AppSize.s20,),
              selectMyWorkWidget,

            ],
          ),
        ),
      ),
    );
  }

  void _onNotificationIconClick() {
    _homeViewModel.onTabChange(_homeViewModel.notificationsIndex);
  }
}
