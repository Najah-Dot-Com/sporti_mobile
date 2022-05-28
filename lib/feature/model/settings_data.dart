class SettingData {
  SettingData({
    this.setting,
    this.systemMessage,
    this.maxGift
  });

  List<Setting>? setting;
  String? systemMessage;
  String? maxGift;

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
    setting: json["setting"] == null ? null : List<Setting>.from(json["setting"].map((x) => Setting.fromJson(x))),
    systemMessage: json["system_message"] == null ? null : json["system_message"],
    maxGift: json["max_gift"] == null ? null : json["max_gift"],
  );

  Map<String, dynamic> toJson() => {
    "setting": setting == null ? null : List<dynamic>.from(setting!.map((x) => x.toJson())),
    "system_message": systemMessage == null ? null : systemMessage,
    "max_gift": maxGift == null ? null : maxGift,
  };
}

class Setting {
  Setting({
    this.image,
    this.title,
    this.description,
  });

  String? image;
  String? title;
  String? description;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    image: json["image"] == null ? null : json["image"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
  };
}
