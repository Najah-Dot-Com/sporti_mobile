import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;
  int? tabControllerIndex = 0;
  var notificationsIndex = 2;

  @override
  void onInit() {
    super.onInit();
    tabController ??= TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  // void initTabController(TabController? tabController) {
  //   if (tabController == null) {
  //     this.tabController = tabController;
  //     update();
  //   }
  // }

  void onTabChange(var index) {
    if (tabController != null) {
      tabController?.animateTo(index);
      tabControllerIndex = index;
      update();
    }
  }
}
