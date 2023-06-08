// To parse this JSON data, do
//
//     final exchangeModel = exchangeModelFromJson(jsonString);

import 'dart:convert';

ExchangeModel exchangeModelFromJson(String str) => ExchangeModel.fromJson(json.decode(str));

String exchangeModelToJson(ExchangeModel data) => json.encode(data.toJson());

class ExchangeModel {
  String exchangeId;
  String fromId;
  String toId;
  String status;
  int inValue;
  int outValue;
  String withdrawTransactionId;
  String depositAddress;
  String withdrawAddress;
  String refundAddress;
  int createdAt;
  int updatedAt;

  ExchangeModel({
    required this.exchangeId,
    required this.fromId,
    required this.toId,
    required this.status,
    required this.inValue,
    required this.outValue,
    required this.withdrawTransactionId,
    required this.depositAddress,
    required this.withdrawAddress,
    required this.refundAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) => ExchangeModel(
    exchangeId: json["exchangeId"],
    fromId: json["fromId"],
    toId: json["toId"],
    status: json["status"],
    inValue: json["inValue"],
    outValue: json["outValue"],
    withdrawTransactionId: json["withdrawTransactionId"],
    depositAddress: json["depositAddress"],
    withdrawAddress: json["withdrawAddress"],
    refundAddress: json["refundAddress"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "exchangeId": exchangeId,
    "fromId": fromId,
    "toId": toId,
    "status": status,
    "inValue": inValue,
    "outValue": outValue,
    "withdrawTransactionId": withdrawTransactionId,
    "depositAddress": depositAddress,
    "withdrawAddress": withdrawAddress,
    "refundAddress": refundAddress,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
