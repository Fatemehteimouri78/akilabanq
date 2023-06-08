import 'dart:convert';

TransactionModel transactionsModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  int timestamp;
  double value;
  String from;
  String to;
  int confirmations;
  String type;
  bool error;

  TransactionModel({
    required this.timestamp,
    required this.value,
    required this.from,
    required this.to,
    required this.confirmations,
    required this.type,
    required this.error,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    timestamp: json["timestamp"]??DateTime.now().millisecondsSinceEpoch,
    value: json["value"]?.toDouble(),
    from: json["from"],
    to: json["to"],
    confirmations: json["confirmations"],
    type: json["type"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "value": value,
    "from": from,
    "to": to,
    "confirmations": confirmations,
    "type": type,
    "error": error,
  };
}
