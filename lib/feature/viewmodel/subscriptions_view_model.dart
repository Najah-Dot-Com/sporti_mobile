import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/view/appwidget/dialog/gloable_dialog_widget.dart';
import 'package:sporti/network/api/feature/subscriptions_feature.dart';
import 'package:sporti/network/api/purchases/constance_purchases.dart';
import 'package:sporti/network/api/purchases/purchases_api.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';

class SubscriptionsViewModel extends GetxController {
  bool isLoading = false;
  List<PlanData> subscriptionsList = [];
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    initListener();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  //this for all packages
  Future<void> allSubscriptionsPlan() async {
    try {
      isLoading = true;
      update();
      await SubscriptionsFeature.getInstance
          .allSubscriptionsPlan()
          .then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value != null && value.isNotEmpty) {
          subscriptionsList.clear();
          subscriptionsList = value;
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  bool isSelectedIndex(int index) {
    if (selectedIndex == index) {
      return true;
    }
    return false;
  }

  bool isSelectedEqualedCurrent(PlanData currentPlan) {
    List<PlanData> allSubscriptions = SharedPref.instance.getAllSubscriptions();

    if (allSubscriptions.isNotEmpty &&
        (allSubscriptions[selectedIndex].id == currentPlan.id ||
            allSubscriptions[selectedIndex].androidId ==
                currentPlan.androidId)) {
      return true;
    }
    return false;
  }

  void subscriptions() async {
    // 1 == free plan
    if (subscriptionsList[selectedIndex].id != 1) {
      var product = await PurchasesApi.instance.getProductById(Platform.isIOS
          ? subscriptionsList[selectedIndex].iosId
          : subscriptionsList[selectedIndex].androidId);
      bool isSuccessful = await PurchasesApi.instance.purchasesSubscriptions(
          product,
          androidId: subscriptionsList[selectedIndex].androidId);
      if (isSuccessful) {
        _doSubscriptions();
      }
    } else {
      //todo this for free
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        showAnimatedDialog(GlobalDialogWidget(
          title: AppStrings.txtAttentions.tr,
          subTitle: AppStrings.subscriptionsFreeHint.tr,
          isLoading: false,
          isTwoBtn: true,
          onCancelBtnClick: () => Get.back(),
          onOkBtnClick: () {
            freeSubscriptions();
            Get.back();
          },
        ));
      });

    }
  }

  freeSubscriptions()async{
    Map<String, dynamic> map = {
      ConstanceNetwork.isSubscrip: true,
      ConstanceNetwork.planId: subscriptionsList[selectedIndex].id.toString(),
      'plan_start_date':
      DateFormat("dd-MM-yyyy").format(DateTime.now()).toString(),
      'plan_end_date': DateFormat("dd-MM-yyyy")
          .format(DateTime.now()
          .add(const Duration(days: ConstancePurchases.oneMonth)))
          .toString()
    };

    isLoading = true;
    update();
    try {
      SubscriptionsFeature.getInstance.subscriptionsToPlan(map).then((value) {
        if (value.status) {
          loginAgain();
          snackSuccess("", value.message);
          isLoading = false;
          update();
        } else {
          snackError("", value.message);
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        isLoading = false;
        update();
        Logger().e(onError);
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  void _doSubscriptions() {
    Map<String, dynamic> map = {};
    if (subscriptionsList[selectedIndex].androidId ==
        ConstancePurchases.basicId) {
      //todo this for three month
      map = {
        ConstanceNetwork.isSubscrip: true,
        ConstanceNetwork.planId: subscriptionsList[selectedIndex].id.toString(),
        'plan_start_date':
            DateFormat("dd-MM-yyyy").format(DateTime.now()).toString(),
        'plan_end_date': DateFormat("dd-MM-yyyy")
            .format(DateTime.now()
                .add(const Duration(days: ConstancePurchases.threeMonth)))
            .toString()
      };
    } else if (subscriptionsList[selectedIndex].androidId ==
        ConstancePurchases.unLimitedId) {
      //todo this for unlimited month
      map = {
        ConstanceNetwork.isSubscrip: true,
        ConstanceNetwork.planId: subscriptionsList[selectedIndex].id.toString(),
        'plan_start_date':
            DateFormat("dd-MM-yyyy").format(DateTime.now()).toString(),
        'plan_end_date': DateFormat("dd-MM-yyyy")
            .format(DateTime.now()
                .add(const Duration(days: ConstancePurchases.unLimitedMonth)))
            .toString()
      };
    } else {
      //todo this for free
      map = {
        ConstanceNetwork.isSubscrip: true,
        ConstanceNetwork.planId: subscriptionsList[selectedIndex].id.toString(),
        'plan_start_date':
            DateFormat("dd-MM-yyyy").format(DateTime.now()).toString(),
        'plan_end_date': DateFormat("dd-MM-yyyy")
            .format(DateTime.now()
                .add(const Duration(days: ConstancePurchases.oneMonth)))
            .toString()
      };
    }

    isLoading = true;
    update();
    try {
      SubscriptionsFeature.getInstance.subscriptionsToPlan(map).then((value) {
        if (value.status) {
          loginAgain();
          snackSuccess("", value.message);
          isLoading = false;
          update();
        } else {
          snackError("", value.message);
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        isLoading = false;
        update();
        Logger().e(onError);
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  void initListener() {
    //initListener
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (SharedPref.instance.getUserData().plan != null) {
        if (SharedPref.instance.getUserData().plan?.type ==
            ConstancePurchases.freeType) {
          changeSelectedIndex(0);
        } else if (SharedPref.instance.getUserData().plan?.type ==
            ConstancePurchases.basicType) {
          changeSelectedIndex(1);
        } else if (SharedPref.instance
                .getUserData()
                .plan
                ?.type
                ?.toLowerCase() ==
            ConstancePurchases.unLimitedType.toLowerCase()) {
          changeSelectedIndex(2);
        } else {
          changeSelectedIndex(0);
        }
      }
    });
  }
}
