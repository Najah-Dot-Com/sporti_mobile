import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/categories_mywork_list/widget/mywork_list_item_widget.dart';
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

class CategoriesMyWorkListView extends StatelessWidget {
  const CategoriesMyWorkListView({Key? key}) : super(key: key);
  static final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(HomeViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData) => AppBar(
    automaticallyImplyLeading: true,
    centerTitle: false,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          txt: AppStrings.txtHello.tr + " Osama ",
          textStyle: themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        // const SizedBox(height: AppSize.s10,),
        Transform(
          transform: Matrix4.translationValues(0, 30, 0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: CustomTextView(
              txt: AppStrings.txtPackageRepeatedTimes.tr ,
              textStyle: themeData.textTheme.subtitle2?.copyWith(color: AppColor.grey),
            ),
          ),
        ),
      ],
    ),
    toolbarHeight: AppSize.s120,
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


  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(themeData),
      body: ListView.builder(
        physics: AppStyleScroll.customScrollViewIOS(),
        shrinkWrap: true,
        itemCount: 10,
        padding:const EdgeInsets.symmetric(horizontal: AppSize.s28 ,),
        itemBuilder: (context , index){
          return  MyWorkListItemWidget(index: index,);
        },
      ),
    );
  }

  void _onNotificationIconClick() {
    _homeViewModel.onTabChange(_homeViewModel.notificationsIndex);
  }
}