import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/categories_mywork_list/categories_mywork_list_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/bottom_navigation_bar.dart';
import 'package:sporti/feature/view/views/home_page/widget/home_page_tab.dart';
import 'package:sporti/feature/view/views/notifications/notifications_view.dart';
import 'package:sporti/feature/view/views/profile/profile_view.dart';
import 'package:sporti/feature/view/views/search/search_view.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/connectivity_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  Widget get floatingBtn => FloatingActionButton(
         elevation: 0,
        child: Icon(
          Icons.search,
          color: AppColor.white,
          size: AppSize.s40,
        ),
        backgroundColor: AppColor.primary,
        onPressed: _onSearchClick,
      );

  Widget bottomNavBar(ThemeData themeData) => const BottomNavigationBarWidget();

  final List<Widget> bottomNavBarList = [
    const HomePageTab(), //home page
    const CategoriesMyWorkListView(), //my work
    NotificationsView(), //notifications
    ProfileView(), //profile
  ];

  final HomeViewModel _homeViewModel = Get.put<HomeViewModel>(HomeViewModel());

  @override
  void initState() {
    // TODO: implement initState
    // _homeViewModel.initTabController(TabController(vsync: this, length: bottomNavBarList.length,initialIndex: 0));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _homeViewModel.onTabChange(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return ConnectivityWidget(
      scaffold: Scaffold(
        extendBody: true,
        bottomNavigationBar:
            SizedBox(height: AppSize.s90, child: bottomNavBar(themeData)),
        floatingActionButton: SizedBox(
            width: AppSize.s85, height: AppSize.s85, child: floatingBtn),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: DoubleBackToCloseApp(
          snackBar:  SnackBar(
            content: Text(AppStrings.txtBackToEnd.tr),
          ),
          child: GetBuilder<HomeViewModel>(builder: (logic) {
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: logic.tabController,
              children: bottomNavBarList,
            );
          }),
        ),
      ),
    );
  }

  void _onSearchClick() {
    Get.to(const SearchView());
  }
}
