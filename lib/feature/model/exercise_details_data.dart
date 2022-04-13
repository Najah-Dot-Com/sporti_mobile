class ExerciseDetailsData {
  ExerciseDetailsData({
    this.id,
    this.title,
    this.description,
    this.time,
    this.image,
    this.updatedAt,
  });

  dynamic id;
  String? title;
  String? description;
  dynamic time;
  String? image;
  DateTime? updatedAt;

  factory ExerciseDetailsData.fromJson(Map<String, dynamic> json) => ExerciseDetailsData(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    time: json["time"] == null ? null : json["time"],
    image: json["image"] == null ? null:json["image"],
    updatedAt: json["updated_at"] == null ? null:DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "time": time == null ? null : time,
    "image": image == null ? null:image,
    "updated_at": updatedAt == null ? null:updatedAt?.toIso8601String(),
  };
}
