class BalanceData {
  BalanceData({
    this.finish,
    this.balance,
  });

  int? finish;
  String? balance;

  factory BalanceData.fromJson(Map<String, dynamic> json) => BalanceData(
    finish: json["finish"] == null ? 0 : json["finish"],
    balance: json["balance"] == null ? 0 : json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "finish": finish == null ? null : finish,
    "balance": balance == null ? null : balance,
  };
}
