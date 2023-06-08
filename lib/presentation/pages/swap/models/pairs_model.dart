// To parse this JSON data, do
//
//     final estimateModel = estimateModelFromJson(jsonString);

import 'dart:convert';




PairsModel estimateModelFromJson(String str) => PairsModel.fromJson(json.decode(str));

String estimateModelToJson(PairsModel data) => json.encode(data.toJson());

class PairsModel {
  int fromId;
  int toId;
  String? senderName;
  String? senderIcon;
  String? senderSym;
  String? senderAddress;
  double? senderBalance;
  String? receiverName;
  String? receiverIcon;
  String? receiverSym;
  String? receiverAddress;
  double ? receiverBalance;
  double ? receiverValue;
  double minimum;
  double maximum;
  double feeRate;


  PairsModel({
    required this.fromId,
    required this.toId,
    this.senderName,
    this.senderIcon,
    this.senderSym,
    this.senderAddress,
    this.senderBalance,
    this.receiverName,
    this.receiverIcon,
    this.receiverSym,
    this.receiverAddress,
    this.receiverBalance = 0.0,
    this.receiverValue = 0.0,

    required this.minimum,
    required this.maximum,
    required this.feeRate,

  });

  factory PairsModel.fromJson(Map<String, dynamic> json) =>
      PairsModel(
        fromId: int.parse(json['fromId']),
        toId: int.parse(json['toId']),

        minimum: json["minimum"]?.toDouble() ?? 0.0,
        maximum: json["maximum"]?.toDouble() ?? 0.0,
        feeRate: json["feeRate"]?.toDouble() ?? 0.0,

      );

  Map<String, dynamic> toJson() =>
      {
        "fromId": fromId,
        "toId": toId,

        "minimum": minimum,
        "maximum": maximum,
        "feeRate": feeRate,

      };
}
