import 'package:sporti/feature/model/plan_data.dart';

class UserData {
  UserData(
      {this.fullname,
      this.token,
      this.expiresIn,
      this.isVerify = false,
      this.isHaveSubscriptions = false,
      this.finish,
      this.balance,
      this.email,
      this.plan,
      this.planStartDate,
      this.planEndDate,
      this.picture,
      this.username});

  String? fullname;
  String? token;
  DateTime? expiresIn;
  bool? isVerify;
  bool? isHaveSubscriptions;
  String? username;
  String? email;
  String? picture;
  int? finish;
  String? balance;
  PlanData? plan;
  DateTime? planStartDate;
  DateTime? planEndDate;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        fullname: json["fullname"] == null ? null : json["fullname"],
        token: json["token"] == null ? null : json["token"],
        isVerify: json["isVerify"] == null ? false : json["isVerify"],
        isHaveSubscriptions:
            json["isSubscrip"] == null ? false : json["isSubscrip"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        finish: json["finish"] == null ? null : json["finish"],
        balance: json["balance"] == null ? null : json["balance"],
        picture: json["picture"] == null ? null : json["picture"],
        plan: json["Plan"] == null ? null : PlanData.fromJson(json["Plan"]),
        planStartDate: json["plan_start_date"] == null
            ? null
            : DateTime.parse(json["plan_start_date"]),
        planEndDate: json["plan_end_date"] == null
            ? null
            : DateTime.parse(json["plan_end_date"]),
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
        "isSubscrip": isHaveSubscriptions == null ? null : isHaveSubscriptions,
        "expires_in": expiresIn == null ? null : expiresIn?.toIso8601String(),
        "Plan": plan == null ? null : plan!.toJson(),
        "plan_start_date": planStartDate == null
            ? null
            : "${planStartDate?.year.toString().padLeft(4, '0')}-${planStartDate?.month.toString().padLeft(2, '0')}-${planStartDate?.day.toString().padLeft(2, '0')}",
        "plan_end_date": planEndDate == null
            ? null
            : "${planEndDate?.year.toString().padLeft(4, '0')}-${planEndDate?.month.toString().padLeft(2, '0')}-${planEndDate?.day.toString().padLeft(2, '0')}",
      };
}
