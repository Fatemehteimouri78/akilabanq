import 'dart:io';

import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_price.dart';
import 'package:akilabanq/presentation/pages/wallet/model/transactios.dart';
import 'package:akilabanq/utils/constant/app_variable.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TokenTransactionsRepo {
  static getTransActions(int id, String address) async {
    final dio = Dio();
    String endPoint =
        '/wallet/id/$id/address/$address/transactions';
    List<TransactionModel> transactions = [];

    try {
      final response = await dio
          .get('${AppVariables.baseUrl}$endPoint',
              options: Options(
                  headers: {HttpHeaders.contentTypeHeader: "application/json"}))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        print("transactions");
        print(response.toString());
        response.data['data'].forEach((element) {
          transactions.add(TransactionModel.fromJson(element));
        });
        print(transactions.length);
        return transactions;
      }
    }on DioError catch (e) {
      print(e.response);
    }
  }

  static Future<bool> transfare(
      String address, String amount, String privateKey, int id) async {
    Dio dio = Dio();
    Map<String, dynamic> data = {
      "fromPrivateKey": privateKey,
      "toAddress": address,
      "value": double.parse(amount),
    };
    print(data);
    try {
      final response = await dio
          .post("${AppVariables.baseUrl}/wallet/id/$id/address/transfer",
              data: data,
              options: Options(
                  headers: {HttpHeaders.contentTypeHeader: "application/json"}))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }on DioError catch (e) {
      print('Error ::: ${e.response}');
      return false;
    }
  }

  static Future<String> estimateFee(
      String address, String amount, String fromAddress, int id) async {
    Dio dio = Dio();
    Map<String, dynamic> data = {
      "fromAddress": fromAddress,
      "toAddress": address,
      "value": double.parse(amount),
    };
    print("wallet/id/$id/estimate-fee");
    print(data);
    try {
      final response = await dio
          .post("${AppVariables.baseUrl}/wallet/id/$id/estimate-fee",
          data: data,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response.data["data"]["value"].toString();
      } else {
        return response.data["message"]??"something wrong";
      }
    }on DioError catch (e) {
      print('Error ::: ${e.response}');
      showWarningToast(e.response?.data["message"]??"something wrong");
      return e.response?.data["message"]??"something wrong";
    }
  }

 static Future getBalance(int id, String address)async {
    Dio dio = Dio();
    double? currentBalance;
    final String endPoint = "/wallet/id/$id/address/$address/balance";

    try {
      final response = await dio.get("${AppVariables.baseUrl}$endPoint",
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));


      currentBalance =response.data['data']['balance'].toDouble() ;
      return currentBalance;
    } on DioError catch (e) {}
  }


 static Future<TokenPrice?> getTokenPrice(String symbol)async {
    Dio dio = Dio();
    TokenPrice? tokenPrice;
    
    final String endPoint = "${AppVariables.baseUrl1}/price/symbol/${symbol}USDT";
    if (kDebugMode) {
      print("endPoint");
      print(endPoint);
    }
    try {
      final response = await dio.get(endPoint,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      List<dynamic> list = (response.data as List<dynamic>);
      tokenPrice = list.isNotNulOrEmpty ? TokenPrice.fromJson(list.first):null;
      return tokenPrice;
    } on DioError catch (e) {}
    return null;
  }
}
