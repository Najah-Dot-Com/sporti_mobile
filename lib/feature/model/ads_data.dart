class AdsData {
  AdsData({
    this.id,
    this.image,
    this.url,
  });

  int? id;
  String? image;
  String? url;

  factory AdsData.fromJson(Map<String, dynamic> json) => AdsData(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "url": url == null ? null : url,
  };
}