class UserData {
  UserData({
    this.fullname,
    this.token,
    this.expiresIn,
  });

  String? fullname;
  String? token;
  DateTime? expiresIn;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        fullname:json["fullname"] == null ? null: json["fullname"],
        token:json["token"] == null ? null: json["token"],
        expiresIn:json["expires_in"] == null ? null: DateTime.parse(json["expires_in"]),
      );

  Map<String, dynamic> toJson() => {
        "fullname":fullname == null ? null: fullname,
        "token":token == null ? null: token,
        "expires_in":expiresIn == null ? null: expiresIn?.toIso8601String(),
      };
}
