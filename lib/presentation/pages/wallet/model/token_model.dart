import 'dart:convert';

TokenModel tokenmodelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenmodelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  TokenModel(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.type,
      required this.decimals,
      required this.confirmationBlock,
      required this.contractAddress,
      required this.icon,
      required this.blockchain,
      required this.network,
      required this.chainId,
      required this.address,
      required this.privateKey,
      this.balance,
      this.tokenValue,
      this.price});

  int id;
  String name;
  double? price;
  String symbol;
  String type;
  int decimals;
  int confirmationBlock;
  String contractAddress;
  double? balance;
  double? tokenValue;
  String icon;
  String blockchain;
  String network;
  int chainId;
  String address;
  String privateKey;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        id: int.parse(json["id"].toString()),
        name: json["name"],
        symbol: json["symbol"],
        decimals: json["decimals"],
        icon: json["icon"],
        blockchain: json["blockchain"],
        network: json["network"].toString(),
        chainId: json["chainId"] ?? 0,
        address: json["address"].toString() ?? '',
        privateKey: json["privateKey"] ?? '',
        confirmationBlock: json['confirmationBlock'] ?? 0,
        contractAddress: json['contractAddress'].toString() ?? '',
        type: json['type'] ?? '',
        balance: json['balance'] ?? 0.0,
        price: json['price'] ?? 0.0,
        tokenValue: json['tokenValue'] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        'balance': balance,
        'price': price,
        'tokenValue': tokenValue,
        "symbol": symbol,
        "decimals": decimals,
        "icon": icon,
        "blockchain": blockchain,
        "network": network,
        "chainId": chainId,
        "address": address,
        "privateKey": privateKey,
      };
}
