import 'dart:io';

import 'package:akilabanq/presentation/pages/swap/models/exchange_model.dart';
import 'package:akilabanq/presentation/pages/swap/models/pairs_model.dart';
import 'package:akilabanq/utils/constant/app_variable.dart';
import 'package:akilabanq/utils/secure_storage.dart';
import 'package:akilabanq/utils/storage.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:dio/dio.dart';

class ExchangeRepo {
  static Future exchange(
      {required int fromId, required String senderAddress, required int toId, required String receiverAddress, required String value}) async {
    Dio dio = Dio();
    final String? privateKey = await storageRead('privateKey');
    final data = {
      "userId": privateKey,
      "fromId": fromId.toString(),
      "toId": toId.toString(),
      "senderAddress": senderAddress,
      "receiverAddress": receiverAddress,
      "value": double.parse(value)
    };
    print("/exchange");
    print(data);
    try {
      final response = await dio.post("${AppVariables.baseUrl}/exchange",
          data: data, options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));


      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response : ${response.toString()}" );
        confirmExchange(response.data['data']['exchangeId']);
      }
    } on DioError catch (e) {
      print(e.response);
    }
  }

  static confirmExchange(String exchangeId) async {
    Dio dio = Dio();
    final String? privateKey = await storageRead('privateKey');
    final data = {
      "exchangeId": exchangeId,
      "privateKey": privateKey,
    };
    print("/exchange/confirm");
    print(data);
    try{
      final response = await dio.post("${AppVariables.baseUrl}/exchange/confirm",
          data: data, options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"})).timeout(Duration(seconds: 10));
      print(response);
    } on DioError catch(e){
      print(e.response);
      showWarningToast(e.response!.data['message'].toString());
    }

  }

  static Future getPairs() async {
    Dio dio = Dio();
    List<PairsModel> pairs = [];
    try {
      final response =
          await dio.get("${AppVariables.baseUrl}/exchange/pairs", options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      response.data['data'].forEach((pair) {
        print(pair);
        pairs.add(PairsModel.fromJson(pair));
      });

      return pairs;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  static Future estimate(int fromId, int toId, String value) async {
    Dio dio = Dio();
    double? currentEstimate = 0.0;
    var data = {"fromId": fromId.toString(), "toId": toId.toString(), "value": double.parse(value)};
    print(data);
    try {
      final response = await dio.post("${AppVariables.baseUrl}/exchange/estimate",
          data: data, options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      print(response);
      print('rrrr : ${response.data['data']['value']}');
      currentEstimate = response.data['data']['value'];
      return currentEstimate;
    } on DioError catch (e) {
      print(e.response);
      showWarningToast(e.response!.data['message']);
      return 0.0;
    }
  }

  static Future exchangeHistory() async {
    Dio dio = Dio();
    List<ExchangeModel> exchanges = [];
    const String endPoint = '/exchange/user/randomUserId?currentPage=1&pageSize=50';

    try {
      final response = await dio
          .get("${AppVariables.baseUrl}$endPoint", options: Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}))
          .timeout(Duration(seconds: 10));
      response.data['data']["exchanges"].forEach((exchange) {
        exchanges.add(ExchangeModel.fromJson(exchange));
      });
      return exchanges;
    } on DioError catch (e) {
      print(e);
    }
  }
}
