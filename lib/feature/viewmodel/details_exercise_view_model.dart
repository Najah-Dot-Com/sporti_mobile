import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercise_details_data.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/api/feature/exercises_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/date_time_util.dart';

class DetailsExerciseViewModel extends GetxController {
  bool isLoading = false;
  ExerciseDetailsData? exerciseDetailsData = ExerciseDetailsData();
  var timeExercise = 0;
  late Timer _timer;
  bool isStartVideo = false;
  bool isEndVideo = false;

  bool? isExerciseDone = false;
  bool? remindMeToRepeatExercise = false;

  String currentSelectedDate = "";
  String currentSelectedTime = "";


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  Future<void> getExerciseDetails(var id) async {
    isLoading = true;
    update();
    try {
      exerciseDetailsData = null;
      await ExercisesFeature.getInstance
          .getDetailsExercisesApi(id)
          .then((value) {
        if (value?.id != null) {
          isLoading = false;
          exerciseDetailsData = value!;
          update();
        } else {
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        isLoading = false;
        update();
        Logger().d(onError);
      });
    } catch (e) {
      isLoading = false;
      update();
      Logger().d(e);
    }
  }

  void startTimer(ExerciseDetailsData? exerciseDetailsData) {
    timeExercise = exerciseDetailsData?.time;
    update();
    const oneSec = Duration(minutes: 1); // every time one min  كل دقيقة
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeExercise == 0) {
          timer.cancel();
          update();
        } else {
          timeExercise--;
          update();
        }
      },
    );
  }

  void onVideoChange(videoPlayerController) {
    if (videoPlayerController.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      isStartVideo = true;
      isEndVideo = false;
      update();
    }

    if (videoPlayerController.value.position ==
        videoPlayerController.value.duration) {
      isEndVideo = true;
      isStartVideo = false;
      update();
    }
  }

  void isDoneChange() {
    isExerciseDone = !isExerciseDone!;
    update();
  }

  void isRemindChange() {
    remindMeToRepeatExercise = !remindMeToRepeatExercise!;
    update();
  }

  addEventExercises(var id ,var type, HomeViewModel homeViewModel,ExercisesData? packageDetails){
    Map<String , dynamic> map = {
      ConstanceNetwork.exerciseIdKey : id,
      ConstanceNetwork.typeKey:type //typeDoneKey || typeReturnKey
    };
    _addEventExercises(map,homeViewModel,packageDetails);
  }



  Future<void> _addEventExercises(Map<String, dynamic> map, HomeViewModel homeViewModel, ExercisesData? packageDetails)async{
    try {

      isLoading = true;
      update();
      await ExercisesFeature.getInstance.addEventExercises(map).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value);
        if (value.status??false) {
          snackSuccess("", value.message);
          isLoading = false;
          isExerciseDone = false;
          currentSelectedDate = "";
          currentSelectedTime = "";
          remindMeToRepeatExercise = false;
          update();
          Get.back();
          // homeViewModel.packagesExercisesDetails(packageDetails?.parentId);
          homeViewModel.getBalanceUser();
        } else {
          snackError("", value.message);
          isLoading = false;
          isExerciseDone = false;
          currentSelectedDate = "";
          currentSelectedTime = "";
          remindMeToRepeatExercise = false;
          update();
        }
      }).catchError((onError) {
        //handle error from value
        snackError("", onError.toString());
        Logger().d(onError.toString());
        isLoading = false;
        isExerciseDone = false;
        currentSelectedDate = "";
        currentSelectedTime = "";
        remindMeToRepeatExercise = false;
        update();
      });
    } catch (e) {
      Logger().d(e.toString());
      isLoading = false;
      isExerciseDone = false;
      currentSelectedDate = "";
      currentSelectedTime = "";
      remindMeToRepeatExercise = false;
      update();
    }
  }

  void showPickerDate()async {
    var dateTimePicker = await dateBiker();
    if (!GetUtils.isNull(dateTimePicker)) {
     Logger().d(DateUtility.convertDateToYMDDate(dateTimePicker!) );
     currentSelectedDate = DateUtility.convertDateToYMDDate(dateTimePicker);
    }
    update();
  }

  void showPickerTime() async{
    var timePicker = await timeBiker();
    if (!GetUtils.isNull(timePicker)) {
      Logger().d(DateUtility.convertTimeTo24(timePicker!));
      currentSelectedTime = "${DateUtility.convertTimeTo24(timePicker).hour}:${DateUtility.convertTimeTo24(timePicker).minute}";
    }
    update();
  }

  Future<void> returnExercise(ExerciseDetailsData exerciseDetailsData, HomeViewModel homeViewModel, ExercisesData? packageDetails) async{

    Map<String , dynamic> map = {
      ConstanceNetwork.exerciseIdKey : exerciseDetailsData.id,
      ConstanceNetwork.returnDateKey : currentSelectedDate,
      ConstanceNetwork.returnTimeKey : currentSelectedTime,
      ConstanceNetwork.typeKey:ConstanceNetwork.typeReturnKey //typeDoneKey || typeReturnKey
    };

    if(currentSelectedDate.isNotEmpty && currentSelectedTime.isNotEmpty) {
      _addEventExercises(map,homeViewModel,packageDetails);
    }
  }



}
