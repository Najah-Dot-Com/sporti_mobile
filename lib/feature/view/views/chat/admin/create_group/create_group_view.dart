import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/model/group_data.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/create_group_bottom_sheet.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/chat/group_view/widget/group_item_list_widget.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/shimmer_your_work_widget.dart';
import 'package:sporti/feature/viewmodel/admin_view_model.dart';
import 'package:sporti/network/firebase/group_features.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';

class CreateGroupView extends StatelessWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: false,
        title: CustomTextView(
          txt: AppStrings.txtCreateForum.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: AppColor.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () => _createGroup(),
        child: Icon(
          Icons.create,
          color: AppColor.white,
        ),
      ),
      body: StreamBuilder(
        stream: GroupFeatures.instance.getGroup(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  top: AppSize.s20, right: AppSize.s16, left: AppSize.s16),
              children: const [
                ShimmerSelectYourWorkWidget(),
                ShimmerSelectYourWorkWidget(),
                ShimmerSelectYourWorkWidget(),
                ShimmerSelectYourWorkWidget(),
                ShimmerSelectYourWorkWidget(),
                ShimmerSelectYourWorkWidget(),
                ShimmerSelectYourWorkWidget(),
              ],
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              padding: const EdgeInsets.only(
                  top: AppSize.s20, right: AppSize.s16, left: AppSize.s16),
              shrinkWrap: true,
              itemBuilder: (ctx, index) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                child: GroupItemListWidget(
                  group: GroupData.fromJson(snapshot.data!.docs[index].data()),
                  isAdmin:true,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      )

      /*GetBuilder<AdminViewModel>(
          init: AdminViewModel(),
          builder: (logic) {
            return ListView(
              padding: const EdgeInsets.only(
                  top: AppSize.s20, right: AppSize.s16, left: AppSize.s16),
              shrinkWrap: true,
              children: const [],
            );
          })*/
      ,
    );
  }

  _createGroup() {
    Get.bottomSheet(const CreateGroupBottomSheet(), isScrollControlled: true);
  }
}
