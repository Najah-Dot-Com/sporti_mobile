import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercise_details_data.dart';
import 'package:sporti/network/api/feature/exercises_feature.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class DetailsExerciseViewModel extends GetxController {
  bool isLoading = false;
  ExerciseDetailsData? exerciseDetailsData = ExerciseDetailsData();
  var timeExercise = 0;
  late Timer _timer;
  bool isStartVideo = false;
  bool isEndVideo = false;

  bool? isExerciseDone = false;
  bool? remindMeToRepeatExercise = false;


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

  addEventExercises(var id ,var type){
    Map<String , dynamic> map = {
      ConstanceNetwork.exerciseIdKey : id,
      ConstanceNetwork.typeKey:type //typeDoneKey || typeReturnKey
    };
    _addEventExercises(map);
  }



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



}
