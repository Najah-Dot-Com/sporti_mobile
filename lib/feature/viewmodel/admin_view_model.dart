import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/network/firebase/group_features.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';

class AdminViewModel extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  void createPost(TextEditingController nameController,
      TextEditingController descController) {
    if (nameController.text.isEmpty) {
      snackError("", AppStrings.txtNameForum.tr + " " + AppStrings.txtFiledRequired.tr);
      return;
    }
    _createPost(nameController, descController);
  }

  void _createPost(TextEditingController nameController,
      TextEditingController descController) async {
    try {
      startLoading();
      await GroupFeatures.instance
              .createGroup(nameController.text.toString(), descController.text.toString())
              .then((value) {
                if(value){
                  snackSuccess("", AppStrings.txtDone.tr);
                  Get.back();
                  endLoading();
                }else{
                  endLoading();
                }
          }).catchError((onError){
            Logger().wtf(onError);
            endLoading();
          });
    } catch (e) {
      Logger().wtf(e);
      endLoading();
    }
  }

  startLoading() {
    isLoading = true;
    update();
  }

  endLoading() {
    isLoading = false;
    update();
  }
}
