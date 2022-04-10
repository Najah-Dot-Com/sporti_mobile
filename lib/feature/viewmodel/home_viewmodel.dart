import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/network/api/feature/exercises_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/sh_util.dart';

class HomeViewModel extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;
  int? tabControllerIndex = 0;
  var notificationsIndex = 2;

  bool isLoading = false;
  bool isLoadingAddMyWork = false;
  List<ExercisesData> exercisesListAll = [];//packages
  List<ExercisesData> packageDetailsExercisesList = [];//packages
  List<ExercisesData> exercisesListRecentlyAll = [];//packages
  List<ExercisesData> exercisesListFavorite = [];//packages
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



  //this for all packages
  Future<void> allPackagesExercises()async{
    try {
      isLoading = true;
      update();
      await ExercisesFeature.getInstance.allExercises({}).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value != null && value.isNotEmpty) {
          exercisesListAll.clear();
          exercisesListAll = value;
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


  //this for  packages details
  Future<void> packagesExercisesDetails(var id)async{
    try {
      isLoading = true;
      update();
      await ExercisesFeature.getInstance.allExercises({ConstanceNetwork.parentIdKey : id}).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value != null && value.isNotEmpty) {
          packageDetailsExercisesList.clear();
          packageDetailsExercisesList = value;
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

  //this for recently added
  Future<void> allPackagesTopExercises()async{
    try {
      isLoading = true;
      update();
      await ExercisesFeature.getInstance.allTopExercises().then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value != null && value.isNotEmpty) {
          exercisesListRecentlyAll.clear();
          exercisesListRecentlyAll = value;
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


  //this for  add to my work
  Future<void> addToMyWork(var id)async{
    try {
      isLoadingAddMyWork = true;
      update();
      await ExercisesFeature.getInstance.addToMyWork({ConstanceNetwork.exerciseIdKey : id}).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value.status??false) {
          snackSuccess("", value.message);
          isLoadingAddMyWork = false;
          update();
          allPackagesExercises();
          allPackagesTopExercises();
          Get.back();
        } else {
          snackError("", value.message);
          isLoadingAddMyWork = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoadingAddMyWork = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoadingAddMyWork = false;
      update();
    }
  }

  addEventExercises(var id ,var type){
    Map<String , dynamic> map = {
      ConstanceNetwork.exerciseIdKey : id,
      ConstanceNetwork.typeKey:type //typeDoneKey || typeReturnKey
    };
    _addEventExercises(map);
  }


  //this for  add to my work
  Future<void> _addEventExercises(Map<String, dynamic> map)async{
    try {

      isLoading = true;
      update();
      await ExercisesFeature.getInstance.addEventExercises(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value.status??false) {
          snackSuccess("", value.message);
          isLoading = false;
          update();
        } else {
          snackError("", value.message);
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


  //this for all packages
  Future<void> getFavoriteExercises()async{
    try {
      isLoading = true;
      update();
      await ExercisesFeature.getInstance.getFavoriteExercises().then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value != null && value.isNotEmpty) {
          exercisesListFavorite.clear();
          exercisesListFavorite = value;
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        // snackError("", onError.toString());
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


//this for all packages
  Future<void> getBalanceUser()async{
    try {
      isLoading = true;
      update();
      await ExercisesFeature.getInstance.getBalanceUser().then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value != null) {
         SharedPref.instance.setUserBalance(value);
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        // snackError("", onError.toString());
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

}
