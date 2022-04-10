class ExercisesData {
  ExercisesData({
    this.title,
    this.description,
    this.time,
    this.isFavorite = false,
    this.image,
    this.updatedAt,
    this.id,
    this.parentId,
    this.isDone= false,
    this.isRetuen= false,
    this.countFinish = 0
  });

  int? id;
  int? parentId;
  int? countFinish;
  bool? isDone;
  bool? isRetuen;
  String? title;
  String? description;
  int? time;
  bool? isFavorite;
  dynamic image;
  dynamic updatedAt;

  factory ExercisesData.fromJson(Map<String, dynamic> json) => ExercisesData(
    id: json["id"] == null ? null : json["id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    isDone: json["isDone"] == null ? false : json["isDone"],
    isRetuen: json["isRetuen"] == null ? false : json["isRetuen"],
    title: json["title"] == null ? null:json["title"],
    description: json["description"] == null ? null:json["description"],
    time: json["time"] == null ? null:json["time"],
    isFavorite: json["isFavorite"] == null ? false:json["isFavorite"],
    image: json["image"] == null ? null:json["image"],
    updatedAt: json["updated_at"] == null ? null:json["updated_at"],
    countFinish: json["countFinish"] == null ? 0:json["countFinish"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "parent_id": parentId == null ? null : parentId,
    "countFinish": countFinish == null ? null : countFinish,
    "title": title == null ? null: title,
    "description": description == null ? null: description,
    "time": time == null ? null: time,
    "isFavorite": isFavorite == null ? null: isFavorite,
    "image": image == null ? null: image,
    "updated_at": updatedAt == null ? null: updatedAt,
    "isDone": isDone == null ? null : isDone,
    "isRetuen": isRetuen == null ? null : isRetuen,
  };
}
