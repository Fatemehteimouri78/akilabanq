import 'dart:io';

import 'package:akilabanq/presentation/pages/wallet/controller/wallet_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_balance.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_price.dart';
import 'package:akilabanq/utils/constant/app_variable.dart';
import 'package:akilabanq/utils/secure_storage.dart';
import 'package:akilabanq/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WalletRepository {
  static Future<List<TokenModel>> getTokens() async {
    List<TokenModel> tokens = [];
    final walletController = Get.find<WalletController>();
    int failCount = 0;

    const String endPoint = '/currencies';
    final Dio dio = Dio();
    try {
      final response = await dio.get("${AppVariables.baseUrl}$endPoint",
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        response.data['data'].forEach((token) {
          tokens.add(TokenModel.fromJson(token));
        });

        storageWrite('tokens', response.data['data']);
        walletController.connectionFail.value = false;
        failCount = 0;
      }
    } on DioError catch (e) {
      if (walletController.connectionFail.value) {
        for (failCount; failCount >= 3; failCount++) {
          Future.delayed(const Duration(seconds: 3), () {
            walletController.getCoins();
          });
        }
        if (failCount == 3) walletController.connectionFail.value = true;
      }

      print(e);
    }
    return tokens;
  }

  static Future<List<TokenModel>> getUserTokens() async {
    List<TokenModel> tokens = [];
    final String? seedData = await loadSeedPhrase(1);
    const String endPoint = '/wallet/addresses/generate';
    final Dio dio = Dio();
    return dio
        .post("${AppVariables.baseUrl}$endPoint",
            data: {"mnemonic": seedData, "deriveIndex": 1},
            options: Options(
                headers: {HttpHeaders.contentTypeHeader: "application/json"}))
        .then((response) {
      if (response.statusCode == 200) {
        response.data['data'].forEach((token) {
          tokens.add(TokenModel.fromJson(token));
        });
      }
      return tokens;
    }).catchError((e) {
      print("ppppppppppppppppppppppppppp");
      print(e);
    });
  }

  static Future<dynamic> getTokensBalance(List<int> id) async {
    Dio dio = Dio();
    List<TokenBalance> tokensBalance = [];
    final String idStr = id.join(',');

    String endPoint = '/wallet/id/$idStr/addresses/balance';
    print(
        "==========================================endPoint$endPoint======================================================");

    final String? seed = await loadSeedPhrase(1);

    try {
      final response = await dio
          .post("${AppVariables.baseUrl}$endPoint",
              data: {"mnemonic": seed, "deriveIndex": 1},
              options: Options(
                  headers: {HttpHeaders.contentTypeHeader: "application/json"}))
          .timeout(Duration(seconds: 10));

      response.data['data'].forEach((element) {
        tokensBalance.add(TokenBalance.fromJson(element));
      });

      return tokensBalance;
    } on DioError catch (e) {
      print(e);
      // throw Exception(e);
    }
  }

  static Future<dynamic> getTokensPrice(List<String> symbol) async {
    Dio dio = Dio();
    List<TokenPrice> tokensPrice = [];
    final String symbolStr = symbol.join('usdt,');

    String endPoint = '/price/symbol/$symbolStr';

    try {
      final response = await dio.get('http://89.116.24.172:8000$endPoint',
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      response.data.forEach((element) {
        tokensPrice.add(TokenPrice.fromJson(element));
      });
      return tokensPrice;
    } on DioError catch (e) {
      print("Erorr : $e");
    }
  }
}
