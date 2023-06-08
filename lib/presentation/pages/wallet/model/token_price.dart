// To parse this JSON data, do
//
//     final tokenPrice = tokenPriceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TokenPrice {
  final String symbol;
  final double price;
  final double priceChangePercent;

  TokenPrice({
    required this.symbol,
    required this.price,
    required this.priceChangePercent,
  });

  bool get isPositive => priceChangePercent >= 0.0;

  TokenPrice copyWith({
    String? symbol,
    double? price,
    double? priceChangePercent,
  }) =>
      TokenPrice(
        symbol: symbol ?? this.symbol,
        price: price ?? this.price,
        priceChangePercent: priceChangePercent ?? this.priceChangePercent,
      );

  factory TokenPrice.fromRawJson(String str) =>
      TokenPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenPrice.fromJson(Map<String, dynamic> json) {
    print("=======================================");
    print(json);
    return TokenPrice(
      symbol: json['symbol'].toString().replaceAll("USDT", ''),
      price: double.parse('${json['price']}'
              .substring(0, ('${json['price']}'.indexOf('.') + 5 + 1))),
      priceChangePercent: double.tryParse(json["priceChangePercent"]??"0.0")??0.0);
  }

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "price": price,
        "priceChangePercent": priceChangePercent,
      };
}
