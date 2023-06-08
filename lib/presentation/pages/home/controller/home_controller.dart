import 'package:akilabanq/presentation/pages/wallet/controller/wallet_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/recieve_token_view.dart';
import 'package:akilabanq/presentation/pages/wallet/send_token_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../category/category_view.dart';
import '../../setting/setting_view.dart';
import '../../swap/swap_view.dart';
import '../../trade/trade_view.dart';
import '../../wallet/token_transactions.dart';
import '../../wallet/wallet_view.dart';
import '../home_view.dart';

class HomeController extends GetxController {
  List<bool> animate = [false, false, false, false, false];
  int pageIndex = 2;

  List<BottomModel> pages = [
    BottomModel(
        page: const TradeView(),
        inActiveIcon: Assets.icons.svg.trade,
        activeIcon: Assets.icons.svg.tradeActive),
    BottomModel(
        page: const SwapView(),
        inActiveIcon: Assets.icons.svg.swap,
        activeIcon: Assets.icons.svg.swapActive),
    BottomModel(
        page: const WalletView(),
        inActiveIcon: Assets.icons.svg.wallet,
        activeIcon: Assets.icons.svg.walletActive),
    BottomModel(
        page: CategoryView(),
        inActiveIcon: Assets.icons.svg.category,
        activeIcon: Assets.icons.svg.categoryActive),
    BottomModel(
        page: const SettingView(),
        inActiveIcon: Assets.icons.svg.setting,
        activeIcon: Assets.icons.svg.settingActive),
    BottomModel(
        page: TokenTransactions(),
        inActiveIcon: Assets.icons.svg.setting,
        activeIcon: Assets.icons.svg.settingActive),
    BottomModel(
        page: RecieveTokenView(),
        inActiveIcon: Assets.icons.svg.setting,
        activeIcon: Assets.icons.svg.settingActive),
    BottomModel(
        page:  SendTokenview(),
        inActiveIcon: Assets.icons.svg.setting,
        activeIcon: Assets.icons.svg.settingActive)
  ];


  PageController pageController = PageController();

  void changePageIndex(int index){
    pageIndex = index;
    if(index < 5) {
      pageController.animateToPage(index,
          duration:
          const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic);
    }

    update();
  }

  void startanimate(int index) async {
    animate[index] = true;
    update();
    stopAnimate(index);
  }

  Future<void> stopAnimate(int index) async {
    await Future.delayed(const Duration(microseconds: 700));
    animate[index] = false;
    update();
  }

  
}
