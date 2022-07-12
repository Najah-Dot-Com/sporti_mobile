import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/subscriptions/all_plan/all_subscriptions_view.dart';
import 'package:sporti/feature/viewmodel/subscriptions_view_model.dart';
import 'package:sporti/network/api/purchases/constance_purchases.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/date_time_util.dart';
import 'package:sporti/util/sh_util.dart';

import 'widget/current_subscribe_widget.dart';

class MyCurrentSubscriptionsView extends StatefulWidget {
  //Current
  const MyCurrentSubscriptionsView({Key? key}) : super(key: key);

  @override
  State<MyCurrentSubscriptionsView> createState() =>
      _MyCurrentSubscriptionsViewState();
}

class _MyCurrentSubscriptionsViewState
    extends State<MyCurrentSubscriptionsView> {
  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtSubscriptions.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
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

  SubscriptionsViewModel get viewModel => Get.put(SubscriptionsViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.initListener();
  }
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      bottomSheet: Container(
        color: AppColor.scaffold,
        padding: const EdgeInsets.only(
            left: AppPadding.p16, right: AppPadding.p16, top: AppPadding.p20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButton(
                    textButton: AppStrings.txtChange.tr,
                    isLoading: false,
                    onClicked: () => _onChangClick())),
            const SizedBox(
              height: AppSize.s65,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p16, right: AppPadding.p16, top: AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: AppSize.s65,
            ),
            CurrentSubscribeWidget(currentSubscriptions: getCurrentPlan()),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextView(
              textAlign: TextAlign.center,
              txt: _endAtDate(),
              textStyle: themeData.textTheme.headline2?.copyWith(
                  color: AppColor.primaryOpacity70, height: AppSize.s1_5),
            ),
          ],
        ),
      ),
    );
  }

  String _endAtDate() {
    // if (SharedPref.instance.getUserData().plan?.type ==
    //         ConstancePurchases.unLimitedType ||
    //     SharedPref.instance.getUserData().plan?.type ==
    //         ConstancePurchases.unlimited) {
    //   return "";
    // }
    if(SharedPref.instance.getUserData().planEndDate!.difference(DateTime.now()).inDays > 965){
      return AppStrings.txtSubscriptionsExpire.tr +
          " ${DateUtility.dateFormatNamed(date: SharedPref.instance.getUserData().planEndDate!.subtract(const Duration(days:((30 * 12) + 5) * 9)))} ";
    }
    return AppStrings.txtSubscriptionsExpire.tr +
        " ${DateUtility.dateFormatNamed(date: SharedPref.instance.getUserData().planEndDate)} ";
  }

  _onChangClick() async {
    var result =
        await Get.to(AllSubscriptionsView(currentPlan: getCurrentPlan()));
    if (result) {
      setState(() {});
    }
  }

  PlanData getCurrentPlan() {
    if (!SharedPref.instance.getUserData().isHaveSubscriptions!) {
      return SharedPref.instance.getAllSubscriptions().first;
    } else {
      //todo here we will return current plan type
      return SharedPref.instance.getUserData().plan!;
    }
  }
}
