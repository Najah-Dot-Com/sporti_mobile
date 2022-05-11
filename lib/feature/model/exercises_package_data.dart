import 'package:logger/logger.dart';

class ExercisesData {
  ExercisesData(
      {this.title,
      this.description,
      this.time,
      this.countExercises,
      this.isFavorite = false,
      this.image,
      this.updatedAt,
      this.id,
      this.parentId,
      this.returnDate,
      this.returnTime,
      this.imageSingleSlide,
      this.isDone = false,
      this.isRetuen = false,
      this.countFinish = 0});

  dynamic id;
  int? parentId;
  int? countFinish;
  bool? isDone;
  bool? isRetuen;
  String? title;
  String? description;
  int? time;
  int? countExercises;
  bool? isFavorite;
  DateTime? returnDate;
  String? returnTime;
  List<String>? image;
  String? imageSingleSlide;
  dynamic updatedAt;

  factory ExercisesData.fromJson(Map<String, dynamic> json) {
    Logger().i(json);
    if (json["image"] is List) {
      return ExercisesData(
        id: json["id"] == null ? null : json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        isDone: json["isDone"] == null ? false : json["isDone"],
        isRetuen: json["isRetuen"] == null ? false : json["isRetuen"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        time: json["time"] == null ? null : json["time"],
        countExercises:
            json["countExercises"] == null ? null : json["countExercises"],
        isFavorite: json["isFavorite"] == null ? false : json["isFavorite"],
        image: json["image"] == null
            ? null
            : List<String>.from(json["image"].map((x) => x.toString())),
        imageSingleSlide: null,
        returnDate: json["return_date"] == null
            ? null
            : DateTime.parse(json["return_date"]),
        returnTime: json["return_time"] == null ? null : json["return_time"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        countFinish: json["countFinish"] == null ? 0 : json["countFinish"],
      );
    } else {
      return ExercisesData(
        id: json["id"] == null ? null : json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        isDone: json["isDone"] == null ? false : json["isDone"],
        isRetuen: json["isRetuen"] == null ? false : json["isRetuen"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        time: json["time"] == null ? null : json["time"],
        countExercises:
            json["countExercises"] == null ? null : json["countExercises"],
        isFavorite: json["isFavorite"] == null ? false : json["isFavorite"],
        image: null,
        imageSingleSlide: json["image"] == null
            ? null
            : json["image"],
        returnDate: json["return_date"] == null
            ? null
            : DateTime.parse(json["return_date"]),
        returnTime: json["return_time"] == null ? null : json["return_time"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        countFinish: json["countFinish"] == null ? 0 : json["countFinish"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "parent_id": parentId == null ? null : parentId,
        "countFinish": countFinish == null ? null : countFinish,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "time": time == null ? null : time,
        "countExercises": countExercises == null ? null : countExercises,
        "isFavorite": isFavorite == null ? null : isFavorite,
        "image": image == null
            ? null
            : List<dynamic>.from(image!.map((x) => x.toString())),
        "updated_at": updatedAt == null ? null : updatedAt,
        "return_date": returnDate == null
            ? null
            : "${returnDate?.year.toString().padLeft(4, '0')}-${returnDate?.month.toString().padLeft(2, '0')}-${returnDate?.day.toString().padLeft(2, '0')}",
        "return_time": returnTime == null ? null : returnTime,
        "isDone": isDone == null ? null : isDone,
        "isRetuen": isRetuen == null ? null : isRetuen,
        "imageSingleSlide": imageSingleSlide == null ? null : imageSingleSlide,
      };
}
