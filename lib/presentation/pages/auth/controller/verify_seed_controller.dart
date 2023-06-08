import 'package:akilabanq/presentation/pages/auth/repositoy/seed_repo.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/controllers/global_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/secure_storage.dart';
import '../../../../utils/storage.dart';
import '../../../../utils/utility.dart';

class VerifySeedsPageController extends GetxController {
  // final _walletRepository = WalletRepository();
  // final _tokenRepository = TokenRepository();
  // final _currencyRepository = CurrencyRepository();

  final _globalController = Get.find<GlobalController>();
  final walletNameController = TextEditingController();

  late List<String> seeds;
  late List<TokenModel> tokens = [];
  RxBool createWalletLoading = false.obs;
  final _shuffledSeeds = <String>[].obs;
  final _selectedSeeds = <String>[].obs;
  final _walletNameFieldVisibility = false.obs;

  @override
  void onInit() {
    getSeeds();
    //TODO: remove this line
    selectedSeeds = seeds; 

    super.onInit();
  }

  List<String> get shuffledSeeds => _shuffledSeeds.value;

  set shuffledSeeds(List<String> value) {
    _shuffledSeeds.value = value;
  }

  List<String> get selectedSeeds => _selectedSeeds.value;

  set selectedSeeds(List<String> value) {
    _selectedSeeds.value = value;
  }

  bool get walletNameFieldVisibility => _walletNameFieldVisibility.value;

  set walletNameFieldVisibility(bool value) {
    _walletNameFieldVisibility.value = value;
  }

  void getSeeds() {
    final mergedSeeds = Get.parameters['seeds'];
    seeds = mergedSeeds!.split(' ');
    shuffledSeeds = List<String>.from(seeds);
    shuffledSeeds.shuffle();
  }

  void onSelectedSeedsChangeHandler(String value) {
    if (value.isNotEmpty) {
      if (selectedSeeds.contains(value)) {
        selectedSeeds.remove(value);
      } else {
        selectedSeeds.add(value);
      }

      if (selectedSeeds.length == 12) {
        validateSeedsOrder();
      } else {
        walletNameFieldVisibility = false;
      }
    } else {
      selectedSeeds = <String>[];
    }
    update();
  }

  void validateSeedsOrder() {
    if (const ListEquality().equals(seeds, selectedSeeds)) {
      walletNameFieldVisibility = true;
    } else {
      makeCustomToast('incorrect_order'.tr);
      walletNameFieldVisibility = false;
      selectedSeeds.clear();
    }
  }

   void requestWalletGeneration() async {
    if (selectedSeeds.length == 12 && const ListEquality().equals(seeds, selectedSeeds)) {
      createWalletLoading.value = true;
      bool existUser = await seedPhraseExists(1);
      update();
      final correctSeeds = selectedSeeds.join(' ');
      tokens = await SeedRepository.verifySeed(correctSeeds);
      saveSeedPhrase(1, correctSeeds);
      createWalletLoading.value = false;
      update();
      Get.offAllNamed(Routes.lockScreen, parameters: {'mode': !existUser ? 'create_wallet' : 'restore_wallet', 'route': Routes.home});
    } else {
      makeCustomToast('Incorrect seeds Order');
    }
  }

  void deleteCurrentSeedWord(String word) {
    selectedSeeds.remove(word);
    update();
  }

  chnageCreateWalletLoading(bool value){
    createWalletLoading.value = value;
    update();

  }

  // void requestWalletGeneration() {
  //   if (walletNameController.text.isNotEmpty) {
  //     Get.dialog(LoadingDialog(),
  //         barrierDismissible: false,
  //         useSafeArea: false,
  //         barrierColor: AppColors.defaultBg);
  //     _walletRepository.restoreMultiCoinWalletByMnemonic(seeds.join(" ")).then(
  //             (value) =>
  //             value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
  //   } else {
  //     makeCustomToast('wallet_name_required'.tr);
  //   }
  // }

  // Future<void> attemptSucceed(List<CoinModel> coins) async {
  //   final walletId =
  //   await _walletRepository.insertWallet(walletNameController.text);
  //   final tokens = <TokenModel>[];
  //   for (final coin in coins) {
  //     for (final id in coin.id!) {
  //       final currency = _currencyRepository.findCurrency(
  //           _globalController.currencySettings, id);
  //       if (currency != null) {
  //         await saveWif(coin.address!, coin.wif!);
  //         tokens.add(TokenModel(
  //             address: coin.address,
  //             balance: 0,
  //             tokenId: id,
  //             walletId: walletId,
  //             settings: currency));
  //       }
  //     }
  //   }
  //   final indexedTokens = updateIndexes(tokens);
  //   await _tokenRepository.insertMultipleTokens(indexedTokens);
  //   await saveSeedPhrase(walletId, seeds.join(" "));
  //   await storageWrite(AppKeys.selectedWallet, walletId);
  //   if (Get.arguments == 'new_wallet') {
  //     Get.find<WalletFragmentController>().initiateSync();
  //     Get.offNamedUntil(Routes.walletCreated, ModalRoute.withName(Routes.main));
  //   } else {
  //     Get.offAllNamed(Routes.walletCreated);
  //   }
  // }

  // List<TokenModel> updateIndexes(List<TokenModel> tokens) {
  //   for (int i = 0; i < _globalController.currencySettings.length; i++) {
  //     for (final token in tokens) {
  //       token.index = i;
  //     }
  //   }
  //   return tokens;
  // }

  void attemptFailed(String message) {
    makeCustomToast(message);
  }
}
