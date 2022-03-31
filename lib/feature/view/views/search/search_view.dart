import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  static final TextEditingController _editingController =
      TextEditingController();

  PreferredSizeWidget myAppBar(ThemeData themeData) => AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        toolbarHeight: AppSize.s100,
        title: Row(
          children: [
            Expanded(
              child: CustomTextFormFiled(
                label: AppStrings.txtSearch.tr,
                onSubmitted: (v) {},
                onChange: (v) {},
                controller: _editingController,
                isSmallPaddingWidth: true,
              ),
            ),
            const SizedBox(
              width: AppSize.s10,
            ),
            IconButton(
              onPressed: () {},
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
          labelPadding: EdgeInsets.all(AppSize.s12),
          tabs: [
            CustomTextView(
              txt: AppStrings.txtPackage.tr,
              textStyle: themeData.textTheme.headline2
                  ?.copyWith(color: AppColor.black),
            ),
            CustomTextView(
              txt: AppStrings.txtExercise.tr,
              textStyle: themeData.textTheme.headline2
                  ?.copyWith(color: AppColor.black),
            )
          ],
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
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: myAppBar(themeData),
      ),
    );
  }
}
