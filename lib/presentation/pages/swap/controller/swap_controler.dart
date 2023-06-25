import 'package:akilabanq/presentation/pages/swap/models/exchange_model.dart';
import 'package:akilabanq/presentation/pages/swap/models/pairs_model.dart';
import 'package:akilabanq/presentation/pages/swap/repository/exchange_repo.dart';
import 'package:akilabanq/presentation/pages/wallet/controller/wallet_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_price.dart';
import 'package:akilabanq/presentation/pages/wallet/repository/token_transactions_repo.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/pairs_search_bar.dart';

class SwapController extends GetxController with GetSingleTickerProviderStateMixin {
  List<PairsModel> pairs = [];
  List<ExchangeModel> exchanges = [];
  List<PairsModel> fromPairs = [];
  List<PairsModel> toPairs = [];
  TokenPrice? currentTokenPrice;
  late PairsModel currentPair;
  late TabController bottomTabController;
  TextEditingController valueController = TextEditingController();
  PageController topTabController = PageController();
  bool gotError = false;

  int currentTab = 0;
  RxDouble currentEstimate = 0.0.obs;
  RxBool pageLoading = false.obs;
  RxBool updatingEstimate = false.obs;
  RxBool exchnageLoading = false.obs;

  void topBarChangeTab(int index) {
    print("index is $index");
    topTabController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    currentTab = index;

    update();
  }

  void bTabchage(int index) {
    bottomTabController.animateTo(index);
    update();
  }

  @override
  void onInit() {
    pageLoading.value = true;
    update();
    bottomTabController = TabController(length: 2, vsync: this);
    getPairs();
    exchangeHistory();
    super.onInit();
  }

  getPairs() async {
    final tokens = Get.find<WalletController>().tokens;
    final List<PairsModel> availablePairs = await ExchangeRepo.getPairs();
    for (var pair in availablePairs) {
      final TokenModel senderToken = tokens.firstWhere((element) => element.id == pair.fromId);
      final TokenModel receiverToken = tokens.firstWhere((element) => element.id == pair.toId);
      bool isDuplicate = pairs.map((e) => e.fromId).toList().contains(pair.fromId);

      final PairsModel pairsModel = PairsModel(
        fromId: pair.fromId,
        senderToken: senderToken,
        receiverToken: receiverToken,
        toId: pair.toId,
        minimum: pair.minimum,
        maximum: pair.maximum,
        feeRate: pair.feeRate,
        senderName: senderToken.name,
        senderIcon: senderToken.icon,
        senderSym: senderToken.symbol,
        senderAddress: senderToken.address,
        senderBalance: senderToken.balance ?? 0.0,
        receiverIcon: receiverToken.icon,
        receiverName: receiverToken.name,
        receiverSym: receiverToken.symbol,
        receiverAddress: receiverToken.address,
        receiverBalance: receiverToken.balance ?? 0.0,
      );
      pairs.add(pairsModel);

      if (!isDuplicate) {
        fromPairs.add(pairsModel);
      }
    }

    currentPair = pairs[0];
    currentTokenPrice = await TokenTransactionsRepo.getTokenPrice(currentPair.senderSym!);
    pageLoading.value = false;
    update();
  }

  setToPairs(int id) {
    toPairs = pairs.where((element) => element.fromId == id).toList();
  }


  Future<void> reversePairs() async {
    PairsModel? nextPair;
    nextPair = pairs.firstWhereOrNull((element) => element.fromId == currentPair.toId && element.toId == currentPair.fromId);
    if(nextPair != null){
      currentPair = nextPair;
      getEstimate(valueController.text);
      currentTokenPrice = await TokenTransactionsRepo.getTokenPrice(currentPair.senderSym!);
      fromPairs = pairs.where((element) => element.fromId == currentPair.fromId).toList();
      toPairs = pairs.where((element) => element.fromId == currentPair.toId).toList();
      update();
    }else{
      showWarningToast("Unavailable!");
    }

  }

  changeCurrentPair(PairsModel pair) async {
    currentPair = pair;
    currentTokenPrice = await TokenTransactionsRepo.getTokenPrice(currentPair.senderSym!);
    print("currentTokenPrice");
    print(currentTokenPrice?.price);
    getEstimate(valueController.text);
    update();
    Get.back();
  }

  getEstimate(String value) async {
    double amount  = double.tryParse(value)??0;
    if(amount < currentPair.minimum){
      showWarningToast(
          "Minimum not met. Enter over ${currentPair.minimum} for swap.");
    }else if(currentPair.maximum != 0 && amount > currentPair.maximum){
      showWarningToast(
          "Exceeded max limit. Enter under ${currentPair.maximum} for swap.");
    }
    else{
      updatingEstimate.value = true;
      currentEstimate.value = await ExchangeRepo.estimate(currentPair.fromId,
          currentPair.toId, value.isEmpty ? 0.0.toString() : value);
      updatingEstimate.value = false;
      update();
    }

  }

  exchangeHistory() async {
    exchanges = await ExchangeRepo.exchangeHistory();
    update();
  }

  exchange() async {
    exchnageLoading.value = true;
    await ExchangeRepo.exchange(
        fromId: currentPair.fromId,
        senderAddress: currentPair.senderAddress!,
        toId: currentPair.toId,
        receiverAddress: currentPair.receiverAddress!,
        value: valueController.text);
    exchnageLoading.value = false;
  }
}
