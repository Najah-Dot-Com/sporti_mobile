class UserData{
  UserData(
      {this.fullname,
      this.token,
      this.expiresIn,
      this.isVerify = false,
      this.finish,
      this.balance,
      this.email,
      this.picture,
      this.username});

  String? fullname;
  String? token;
  DateTime? expiresIn;
  bool? isVerify;
  String? username;
  String? email;
  String? picture;
  int? finish;
  String? balance;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        fullname: json["fullname"] == null ? null : json["fullname"],
        token: json["token"] == null ? null : json["token"],
        isVerify: json["isVerify"] == null ? false : json["isVerify"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        finish: json["finish"] == null ? null : json["finish"],
        balance: json["balance"] == null ? null : json["balance"],
        picture: json["picture"] == null ? null : json["picture"],
        expiresIn: json["expires_in"] == null
            ? null
            : DateTime.parse(json["expires_in"]),
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname == null ? null : fullname,
        "token": token == null ? null : token,
        "isVerify": isVerify == null ? false : isVerify,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "finish": finish == null ? null : finish,
        "balance": balance == null ? null : balance,
        "picture": picture == null ? null : picture,
        "expires_in": expiresIn == null ? null : expiresIn?.toIso8601String(),
      };
}
