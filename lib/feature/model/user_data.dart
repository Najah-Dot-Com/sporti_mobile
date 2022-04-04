class UserData {
  UserData({
    this.fullname,
    this.token,
    this.expiresIn,
    this.isVerify = false,
    this.username
  });

  String? fullname;
  String? token;
  DateTime? expiresIn;
  bool? isVerify;
  String? username;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        fullname:json["fullname"] == null ? null: json["fullname"],
        token:json["token"] == null ? null: json["token"],
        isVerify:json["isVerify"] == null ? false: json["isVerify"],
        username:json["username"] == null ? null: json["username"],
        expiresIn:json["expires_in"] == null ? null: DateTime.parse(json["expires_in"]),
      );

  Map<String, dynamic> toJson() => {
        "fullname":fullname == null ? null: fullname,
        "token":token == null ? null: token,
        "isVerify":isVerify == null ? false: isVerify,
        "username":username == null ? null: username,
        "expires_in":expiresIn == null ? null: expiresIn?.toIso8601String(),
      };
}
