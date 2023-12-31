import 'package:akilabanq/utils/typedef.dart';

class TransfareModel {
  final String type;
  final String tokenName;
  final String tokenSym;
  final double amount;
  final double price;
  final String fromAddress;
  final String toAddress;
  final VoidCallback callBack;

  TransfareModel({
    required this.type,
    required this.tokenName,
    required this.tokenSym,
    required this.amount,
    required this.price,
    required this.fromAddress,
    required this.toAddress,
    required this.callBack,
});

}