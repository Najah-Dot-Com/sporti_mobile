class ExerciseDetailsData {
  ExerciseDetailsData({
    this.id,
    this.title,
    this.description,
    this.time,
    this.image,
    this.video,
    this.updatedAt,
    this.targetMusales
  });

  dynamic id;
  String? title;
  String? description;
  String? targetMusales;
  dynamic time;
  dynamic image;
  String? video;
  DateTime? updatedAt;

  factory ExerciseDetailsData.fromJson(Map<String, dynamic> json) => ExerciseDetailsData(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    targetMusales: json["target_musales"] == null ? null : json["target_musales"],
    time: json["time"] == null ? null : json["time"],
    image: json["image"] == null ? null:json["image"] is List ? json["image"][0]:json["image"],
    video: json["video"] == null ? null:json["video"],
    updatedAt: json["updated_at"] == null ? null:DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "target_musales": targetMusales == null ? null : targetMusales,
    "time": time == null ? null : time,
    "image": image == null ? null:image,
    "video": video == null ? null:video,
    "updated_at": updatedAt == null ? null:updatedAt?.toIso8601String(),
  };
}
