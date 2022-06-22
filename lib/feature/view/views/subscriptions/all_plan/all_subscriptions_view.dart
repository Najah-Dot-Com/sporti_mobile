import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/subscriptions/all_plan/widget/plan_item_widget.dart';
import 'package:sporti/feature/viewmodel/subscriptions_view_model.dart';
import 'package:sporti/network/api/purchases/constance_purchases.dart';
import 'package:sporti/network/api/purchases/purchases_api.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/sh_util.dart';

class AllSubscriptionsView extends StatelessWidget {
  const AllSubscriptionsView({
    Key? key,
    required this.currentPlan,
  }) : super(key: key);
  final PlanData currentPlan;

  PreferredSizeWidget myAppbar(ThemeData themeData) => AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: AppStrings.txtSubscriptions.tr,
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: InkWell(
          onTap: () {
            Get.back(result: true);
          },
          child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.black,
            ),
        ),

      );

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: (){
        Get.back(result: true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: myAppbar(themeData),
        bottomSheet: GetBuilder<SubscriptionsViewModel>(
          init: SubscriptionsViewModel(),
          builder: (logic) {
            return Container(
              color: AppColor.scaffold,
              padding: const EdgeInsets.only(
                  left: AppPadding.p16,
                  right: AppPadding.p16,
                  top: AppPadding.p20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (logic.isLoading &&
                      logic.isSelectedEqualedCurrent(currentPlan))
                    ...[]
                  else ...[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: PrimaryButton(
                            textButton: AppStrings.txtChange.tr,
                            isLoading: logic.isLoading,
                            colorBtn: logic.isSelectedEqualedCurrent(currentPlan) &&  getSubscriptionsDate(SharedPref.instance.getUserData())
                                ? AppColor.grey1
                                : AppColor.primary,
                            onClicked: () =>
                                logic.isSelectedEqualedCurrent(currentPlan)  &&  getSubscriptionsDate(SharedPref.instance.getUserData())
                                    ? () {}
                                    : _onUpdateClick(logic))),
                  ],
                  const SizedBox(
                    height: AppSize.s24,
                  ),
                ],
              ),
            );
          },
        ),
        body: GetBuilder<SubscriptionsViewModel>(
            init: SubscriptionsViewModel(),
            initState: (stata) {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                stata.controller?.allSubscriptionsPlan();
              });
            },
            builder: (logic) {
              if (logic.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                padding: const EdgeInsets.only(
                    left: AppPadding.p16,
                    right: AppPadding.p16,
                    top: AppPadding.p20),
                children: [
                  CustomTextView(
                    textAlign: TextAlign.start,
                    txt: AppStrings.txtChoseSubscriptions.tr,
                    textStyle: themeData.textTheme.headline2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: AppSize.s24,
                  ),
                  if (logic.subscriptionsList.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: logic.subscriptionsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              logic.changeSelectedIndex(index);
                            },
                            child: PlanItemWidget(
                                planData: logic.subscriptionsList[index],
                                isSelectedIndex: logic.isSelectedIndex(index)),
                          );
                        }),
                ],
              );
            }),
      ),
    );
  }

  _onUpdateClick(SubscriptionsViewModel logic) async {
    bool isConfigured = await Purchases.isConfigured;
  bool canMakePayments =   await Purchases.canMakePayments();
    var checkTrialOrIntroductoryPriceEligibility =await Purchases.checkTrialOrIntroductoryPriceEligibility([ConstancePurchases.basicId]);
    Logger().w(canMakePayments);
    Logger().w(checkTrialOrIntroductoryPriceEligibility.entries.first.value.description);
    if(isConfigured && canMakePayments) {
      logic.subscriptions();
    }else{
      snackError("", "The device or user is not allowed to make the purchase");
    }
  }
}
