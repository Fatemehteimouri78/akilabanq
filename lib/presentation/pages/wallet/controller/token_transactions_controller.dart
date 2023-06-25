import 'dart:async';

import 'package:akilabanq/presentation/pages/wallet/controller/wallet_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_price.dart';
import 'package:akilabanq/presentation/pages/wallet/model/transactios.dart';
import 'package:akilabanq/presentation/pages/wallet/repository/token_transactions_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TokenTransactionController extends GetxController {
  late TokenModel currentToken;
   RxDouble currentBalance = 0.0.obs;
   RxInt currentIndex = 0.obs;
   RxDouble estimatedFee = 0.0.obs;
  RxBool loading = false.obs;
  RxBool sendLoading = false.obs;
  RxBool estimateLoading = false.obs;
  List<TransactionModel> transactions = <TransactionModel>[];
  TokenPrice? tokenPrice;
  late Timer _timer;

  // late RxString currentTokenPrice;

  setTokenModel(TokenModel token,{bool showLoading = true}) async {
    print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
    if(showLoading){
      loading.value = true;
    }
    currentToken = token;
    transactions =
        await TokenTransactionsRepo.getTransActions(token.id, token.address)??[];
    tokenPrice = await TokenTransactionsRepo.getTokenPrice(token.symbol);
    getBalance();
  }

  getBalance()  {

    _timer = makePeriodicTimer(const Duration(seconds: 5), fireNow: true,
        (timer) async {
         double? balance = await TokenTransactionsRepo.getBalance(
          currentToken.id, currentToken.address);
         if(balance != currentBalance.value){
           currentBalance.value = balance!;
         }
    });
    loading.value = false;


  }


  Future<bool> trasnfarToken(String address, String amount) async {
    sendLoading.value = true;
    final bool transfar = await TokenTransactionsRepo.transfare(
        address, amount, currentToken.privateKey,currentToken.id);
    sendLoading.value = false;
    return transfar;
  }

  Future<void> estimateFee({required String address, required double amount}) async {
    estimatedFee.value = 0;
    estimateLoading.value = true;
   TokenTransactionsRepo.estimateFee(
        address, amount, currentToken.address,currentToken.id).then((transfar) {
          if(transfar is double){
            estimatedFee.value = transfar;
            estimateLoading.value = false;
          }
    });

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
