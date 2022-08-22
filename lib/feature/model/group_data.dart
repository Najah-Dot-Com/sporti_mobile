class GroupData {
  GroupData({
    this.id,
    this.url,
    this.title,
    this.desc,
    this.timeStamp,
    this.isActive = false
  });

  String? id;
  String? title;
  String? desc;
  dynamic timeStamp;
  String? url;
  bool? isActive;

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    title: json["title"] == null ? null : json["title"],
    desc: json["desc"] == null ? "" : json["desc"],
    timeStamp: json["timeStamp"] == null ? null : json["timeStamp"],
    isActive: json["isActive"] == null ? false : json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "title": title == null ? null : title,
    "desc": desc == null ? null : desc,
    "timeStamp": timeStamp == null ? null : timeStamp,
    "isActive": isActive == null ? false : isActive,
  };

  GroupData copyWith({
    String? id,
    String? title,
    String? desc,
    dynamic? timeStamp,
    String? url,
    bool? isActive = false,
  }) {
    return GroupData(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      timeStamp: timeStamp ?? this.timeStamp,
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
    );
  }
}