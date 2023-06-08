import 'dart:async';
import 'dart:convert';

import 'package:akilabanq/presentation/pages/wallet/model/token_balance.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_price.dart';
import 'package:akilabanq/presentation/pages/wallet/repository/wallet_repo.dart';
import 'package:akilabanq/utils/constant/app_variable.dart';
import 'package:akilabanq/utils/secure_storage.dart';
import 'package:akilabanq/utils/storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final RxList<TokenModel> _tokens = <TokenModel>[].obs;
  RxList<TokenModel> filteredToken = <TokenModel>[].obs;
  RxList<String> categories = <String>['All', 'Tokens', 'Coins'].obs;
  RxBool catChangeLoading = false.obs;
  RxBool getTokenLoading = false.obs;
  RxBool connectionFail = false.obs;
  RxInt currentCategory = 0.obs;
  late StreamSubscription connectivityResult;
  RxBool isOffline = false.obs;

  String category = "All";

  set tokens(List<TokenModel> value) {
    _tokens.value = value;
  }

  List<TokenModel> get tokens => _tokens.value;

  @override
  void onInit() {
    checkConnectivity();

    super.onInit();
  }

  checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isOffline.value = true;
    }
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.vpn) {
      isOffline.value = false;
    }
    getCoins();

    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi || event == ConnectivityResult.mobile || event == ConnectivityResult.vpn) {
        isOffline.value = false;
        getCoins();
      }
    });
  }

  changeCategory(int index) {
    currentCategory.value = index;
    catChangeLoading.value = true;
    if (category == 'All') {
      filteredToken.value = tokens;
    } else if (category == 'Coins') {
      filteredToken.value = tokens.where((element) => element.type == 'coin').toList();
    } else if (category == 'Tokens') {
      filteredToken.value = tokens.where((element) => element.type == 'token').toList();
    } else {
      filteredToken.value = tokens.where((element) => element.blockchain == category).toList();
    }

    catChangeLoading.value = false;
  }

  void getCoins() async {
    if (isOffline.value && storageExists('tokens')) {
      final List storageTokens = json.decode(storageRead('tokens'));

      tokens = storageTokens.map((token) => TokenModel.fromJson(token)).toList();
      connectionFail.value = false;
    } else if (isOffline.value) {
      connectionFail.value = true;
    } else if (!isOffline.value) {
      tokens = await WalletRepository.getUserTokens();
      storageWrite('tokens', json.encode(tokens));

      getCoinsDetail();

      connectionFail.value = false;
    }
    filteredToken.value = tokens;
    getCategories();
    _savePrivateKey();
  }

  getCategories() {
    final List<String> allBlockchin = tokens.map((e) => e.blockchain).toSet().toList();
    allBlockchin.forEach((element) {
      if (!categories.contains(element)) categories.add(element);
    });
  }

  void getCoinsDetail() async {
    final List<int> tokensID = tokens.map((e) => e.id).toList();
    final List<String> tokensSYM = tokens.map((e) => e.symbol).toList();

    if (!isOffline.value) {
      makePeriodicTimer(const Duration(seconds: 10), fireNow: true, (timer) async {
        List<TokenBalance> tokensBalance = await WalletRepository.getTokensBalance(tokensID);

        tokensBalance.forEach((TokenBalance balance) {
          final currentToken = tokens.firstWhere((element) => element.id == balance.id);
          if (currentToken.balance != balance.balance) {
            int index = tokens.indexOf(currentToken);
            tokens[index].balance = balance.balance;
            tokens[index].tokenValue = balance.balance * currentToken.price!;
            changeCategory(currentCategory.value);
          }
        });
      });
      makePeriodicTimer(const Duration(seconds: 10), fireNow: true, (timer) async {
        List<TokenPrice> prices = await WalletRepository.getTokensPrice(tokensSYM);

        prices.forEach((TokenPrice price) {
          final currentToken = tokens.firstWhere((element) => element.symbol.toLowerCase() == price.symbol.toLowerCase());
          if (currentToken.price != price.price) {
            int index = tokens.indexOf(currentToken);
            tokens[index].price = price.price;
            tokens[index].tokenValue = price.price * currentToken.balance!;
            changeCategory(currentCategory.value);
          }
        });
      });
    }
    makePeriodicTimer(const Duration(minutes: 3), fireNow: true, (timer) {
      storageWrite('tokens', json.encode(tokens));
    });
  }

  _savePrivateKey() async {
    if(!storageExists('privateKey')){
      storageWrite('privateKey', tokens.firstWhere((element) => element.id == 17).privateKey);
    }

  }
}

Timer makePeriodicTimer(
  Duration duration,
  void Function(Timer timer) callback, {
  bool fireNow = false,
}) {
  var timer = Timer.periodic(duration, callback);
  if (fireNow) {
    callback(timer);
  }
  return timer;
}
