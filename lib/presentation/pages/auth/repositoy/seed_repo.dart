import 'dart:io';

import 'package:akilabanq/presentation/pages/auth/controller/generate_seed.dart';
import 'package:akilabanq/presentation/pages/auth/controller/verify_seed_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/utils/constant/app_variable.dart';
import 'package:akilabanq/utils/widgets/server_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SeedRepository {
  static Future<List<String>> generateSeed() async {
    print("qqqqqqqqqqqqq");
    List<String> seeds = [];
    const String endPoint = "/wallet/mnemonic/generate";
    final Dio dio = Dio();
    try {
      print("qqqwwwwwwwwwwwwwwwwwww");
      final response = await dio
          .get("${AppVariables.baseUrl}$endPoint",
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }))
          .timeout(Duration(seconds: 10));
      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);

        final String mnemonic = response.data['data']['mnemonic'];
        seeds = mnemonic.split(' ').toList();
        print(seeds);
      }
    } catch (e) {
      print('Erorrr : $e');
      final jenerateSeedController = Get.find<GenerateSeedsPageController>();
      serverDialog(() => jenerateSeedController.generateSeedWords());
    }
    return seeds;
  }

  static Future<dynamic> verifySeed(String data) async {
    List<TokenModel> tokens = [];
    const String endPoint = '/wallet/addresses/generate';
    final Dio dio = Dio();
    try {
      final response = await dio
          .post("${AppVariables.baseUrl}$endPoint",
              data: {"mnemonic": data, "deriveIndex": 1},
              options: Options(
                  headers: {HttpHeaders.contentTypeHeader: "application/json"}))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        response.data['data'].forEach((token) {
          tokens.add(TokenModel.fromJson(token));
        });
        return tokens;
      }
    } catch (e) {
      final verifySeedsController = Get.find<VerifySeedsPageController>();
      verifySeedsController.chnageCreateWalletLoading(false);
      serverDialog(() => verifySeedsController.requestWalletGeneration());
    }
  }
}
