import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/bottom_navigation_bar.dart';
import 'package:sporti/feature/view/views/profile/profile_view.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  Widget get floatingBtn =>
      FloatingActionButton(
        child: Icon(
          Icons.search,
          color: AppColor.white,
        ),
        backgroundColor: AppColor.primary,
        onPressed: () {},
      );

  Widget bottomNavBar(ThemeData themeData) => const BottomNavigationBarWidget();

  PreferredSizeWidget myAppBar(ThemeData themeData) =>
      AppBar(
        centerTitle: false,
        title: CustomTextView(
          txt: AppStrings.txtHello.tr + " Osama ",
          textStyle: themeData.textTheme.headline2?.copyWith(
              color: AppColor.black),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //logic.changeTab(1);
              print('Event');
            },
            minWidth: 48,
            child: Icon(
              Icons.notifications_rounded, //feed_outlined
              size: 24,
              color: AppColor.grey,
            ),

          ),
        ],
      );

  final List<Widget> bottomNavBarList = [
    Container(),//home page
    Container(),//my work
    Container(),//notifications
    const ProfileView(),//profile
  ];

  final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(HomeViewModel());

  @override
  void initState() {
    // TODO: implement initState
    // _homeViewModel.initTabController(TabController(vsync: this, length: bottomNavBarList.length,initialIndex: 0));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(themeData),
      bottomNavigationBar: bottomNavBar(themeData),
      floatingActionButton: floatingBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GetBuilder<HomeViewModel>(builder: (logic) {
        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: logic.tabController,
          children: bottomNavBarList,);
      }),
    );
  }
}
