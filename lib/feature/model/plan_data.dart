class PlanData {


  PlanData({
  this.id,
  this.name,
  this.description,
  this.period,
  this.price,
  this.androidId,
  this.iosId,
  this.type
  });

  int? id;
  String? name;
  String? description;
  String? period;
  String? price;
  String? androidId;
  String? iosId;
  String? type;

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
  id: json["id"] == null ? null : json["id"],
  name: json["name"] == null ? null : json["name"],
  description: json["description"] == null ? null : json["description"],
  period: json["period"] == null ? null : json["period"],
  price: json["price"] == null ? null : json["price"],
  androidId: json["android_id"] == null ? null : json["android_id"],
  iosId: json["ios_id"] == null ? null : json["ios_id"],
  type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
  "id": id == null ? null : id,
  "name": name == null ? null : name,
  "description": description == null ? null : description,
  "period": period == null ? null : period,
  "price": price == null ? null : price,
  "android_id": androidId == null ? null : androidId,
  "ios_id": iosId == null ? null : iosId,
  "type": type == null ? null : type,
  };

  @override
  bool operator ==(Object other) =>
  identical(this, other) ||
  other is PlanData && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id

      .

  hashCode;
}

