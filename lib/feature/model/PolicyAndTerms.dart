// To parse this JSON data, do
//
//     final policyAndTerms = policyAndTermsFromJson(jsonString);

import 'dart:convert';

PolicyAndTerms policyAndTermsFromJson(String str) => PolicyAndTerms.fromJson(json.decode(str));

String policyAndTermsToJson(PolicyAndTerms data) => json.encode(data.toJson());

class PolicyAndTerms {
    PolicyAndTerms({
        this.result,
    });

    List<Result>? result;

    factory PolicyAndTerms.fromJson(Map<String, dynamic> json) => PolicyAndTerms(
        result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.title,
        this.details,
    });

    int? id;
    String? title;
    String? details;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"]??null,
        title: json["title"]??null,
        details: json["details"]??null,
    );

    Map<String, dynamic> toJson() => {
        "id": id??null,
        "title": title??null,
        "details": details??null,
    };
}
