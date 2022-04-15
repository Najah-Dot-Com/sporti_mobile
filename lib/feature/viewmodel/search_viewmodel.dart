import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/network/api/feature/exercises_feature.dart';

class SearchViewModel extends GetxController {
  int initPageIndex = 0;

  bool isLoading = false;
  List<ExercisesData> packageExerciseList = <ExercisesData>[];
  List<ExercisesData> exerciseList = <ExercisesData>[];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  @override
  void onReady() {}

  void onTabChange(var index) {
    initPageIndex = index;
    update();
  }

  onSearchExercise(var searchWord) {
    if (searchWord != null && searchWord.toString().isNotEmpty) {
      _onSearchExercise(searchWord.toString());
    }
  }

  Future<void> _onSearchExercise(String searchWord) async{
    try {
      isLoading = true;
      update();
      await ExercisesFeature.getInstance.searchExercise(searchWord).then((value) async {
        //handle object from value || [save in sharedPreferences]
        Logger().d(value?.toJson());
        if (value != null ) {
          resetLists();
          packageExerciseList = value.packages != null ?value.packages! :[];
          exerciseList = value.exercises != null ?value.exercises! :[];
          isLoading = false;
          update();
        } else {
          resetLists();
          isLoading = false;
          update();
        }
      }).catchError((onError) {
        Logger().d(onError.toString());
        resetLists();
        isLoading = false;
        update();
      });
    } catch (e) {
      resetLists();
      Logger().d(e.toString());
      isLoading = false;
      update();
    }
  }

  void resetLists() {
    packageExerciseList.clear();
    exerciseList.clear();
    update();
  }
}
