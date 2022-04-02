import 'package:get/get.dart';

class SearchViewModel extends GetxController{

  int initPageIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

  void onTabChange(var index) {
      initPageIndex = index;
      update();
    }


}