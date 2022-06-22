import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/search/widget/card_item_widget.dart';
import 'package:sporti/feature/view/views/search/widget/exercises_list_widget.dart';
import 'package:sporti/feature/view/views/search/widget/package_lists_widget.dart';
import 'package:sporti/feature/viewmodel/search_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  static final TextEditingController _searchEditingController =
      TextEditingController();

  SearchViewModel get _searchViewModel => Get.put<SearchViewModel>(SearchViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData, SearchViewModel logic) => AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        toolbarHeight: AppSize.s100,
        title: Row(
          children: [
            Expanded(
              child: CustomTextFormFiled(
                label: AppStrings.txtSearch.tr,
                onSubmitted: (v) {
                  if(v.toString().isNotEmpty){
                    logic.onSearchExercise(_searchEditingController.text.toString());
                  }else{
                    logic.resetLists();
                  }
                },
                onChange: (v) {
                  if(v.toString().isNotEmpty && v.toString().length >= 3){
                    logic.onSearchExercise(_searchEditingController.text.toString());
                  }else if(v.toString().isEmpty){
                    logic.resetLists();
                  }
                },
                controller: _searchEditingController,
                isSmallPaddingWidth: true,
              ),
            ),
            const SizedBox(
              width: AppSize.s10,
            ),
            IconButton(
              onPressed: () {
                _searchEditingController.clear();
                logic.resetLists();
              },
              icon: Icon(
                Icons.close,
                color: AppColor.black,
              ),
            )
          ],
        ),
        bottom: TabBar(
          isScrollable: false,
          indicatorColor: AppColor.primary,
          labelColor: AppColor.primary,
          unselectedLabelColor: AppColor.grey,
          labelPadding: const EdgeInsets.all(AppSize.s12),
          onTap: (index){
            logic.onTabChange(index);
          },
          tabs: [
            CustomTextView(
              txt: AppStrings.txtPackage.tr,
              textStyle: themeData.textTheme.headline2?.copyWith(
                  color: logic.initPageIndex == 0 ? AppColor.primary : AppColor.black),
            ),
            CustomTextView(
              txt: AppStrings.txtExercise.tr,
              textStyle: themeData.textTheme.headline2?.copyWith(
                  color: logic.initPageIndex == 1 ? AppColor.primary : AppColor.black),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GetBuilder<SearchViewModel>(
      init: SearchViewModel(),
      builder: (logic) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: myAppBar(themeData, logic),
            body:const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                PackageExerciseListWidget(),
                ExerciseListWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
