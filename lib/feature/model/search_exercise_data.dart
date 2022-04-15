import 'exercises_package_data.dart';

class SearchExerciseData {
  SearchExerciseData({
    this.packages,
    this.exercises,
  });

  List<ExercisesData>? packages;
  List<ExercisesData>? exercises;

  factory SearchExerciseData.fromJson(Map<String, dynamic> json) => SearchExerciseData(
    packages: json["packages"] == null ? null : List<ExercisesData>.from(json["packages"].map((x) => ExercisesData.fromJson(x))),
    exercises: json["exercises"] == null ? null : List<ExercisesData>.from(json["exercises"].map((x) => ExercisesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "packages": packages == null ? null : List<dynamic>.from(packages!.map((x) => x.toJson())),
    "exercises": exercises == null ? null : List<dynamic>.from(exercises!.map((x) => x.toJson())),
  };
}