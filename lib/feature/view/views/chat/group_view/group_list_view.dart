import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/model/group_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/chat/chat_view/chat_view.dart';
import 'package:sporti/feature/view/views/chat/group_view/widget/group_item_list_widget.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/shimmer_your_work_widget.dart';
import 'package:sporti/network/firebase/group_features.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';

class GroupListView extends StatelessWidget {
  const GroupListView({Key? key}) : super(key: key);
  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
    backgroundColor: AppColor.white,
    centerTitle: false,
    title: CustomTextView(
      txt: AppStrings.txtForum.tr,
      textStyle:
      themeData.textTheme.headline2?.copyWith(color: AppColor.black),
    ),
    // leading: IconButton(
    //   onPressed: () => Get.back(),
    //   icon: Icon(
    //     Platform.isIOS? Icons.arrow_back_ios:Icons.arrow_back,
    //     color: AppColor.black,
    //   ),
    // ),
  );
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      body:StreamBuilder(
        stream: GroupFeatures.instance.getGroup(isActive: true),
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
                child: InkWell(
                  onTap: (){
                    Get.to(ChatView(group: GroupData.fromJson(snapshot.data!.docs[index].data())));
                  },
                  child: GroupItemListWidget(
                    group: GroupData.fromJson(snapshot.data!.docs[index].data()),
                    isAdmin:false,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      )
    // ListView(
      //   padding: const EdgeInsets.only(top: AppSize.s20 , left: AppSize.s16 , right:  AppSize.s16),
      //   // mainAxisAlignment: MainAxisAlignment.start,
      //   // crossAxisAlignment: CrossAxisAlignment.start,
      //   children:   [
      //
      //   ],
      // ),
    );
  }
}
