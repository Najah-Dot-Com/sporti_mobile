class ExercisesData {
  ExercisesData({
    this.title,
    this.description,
    this.time,
    this.isFavorite = false,
    this.image,
    this.updatedAt,
  });

  String? title;
  String? description;
  int? time;
  bool? isFavorite;
  dynamic image;
  dynamic updatedAt;

  factory ExercisesData.fromJson(Map<String, dynamic> json) => ExercisesData(
    title: json["title"] == null ? null:json["title"],
    description: json["description"] == null ? null:json["description"],
    time: json["time"] == null ? null:json["time"],
    isFavorite: json["isFavorite"] == null ? false:json["isFavorite"],
    image: json["image"] == null ? null:json["image"],
    updatedAt: json["updated_at"] == null ? null:json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null: title,
    "description": description == null ? null: description,
    "time": time == null ? null: time,
    "isFavorite": isFavorite == null ? null: isFavorite,
    "image": image == null ? null: image,
    "updated_at": updatedAt == null ? null: updatedAt,
  };
}
