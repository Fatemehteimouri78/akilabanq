import 'package:akilabanq/presentation/pages/splash/controller/intro_controller.dart';
import 'package:akilabanq/presentation/pages/splash/intro.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class IntroPage extends GetView<IntroPageController> {
  final introItems = [
    IntroSliderItem(Assets.images.intro1.path, 'Create account'.tr,
        'Take the first step towards building your crypto portfolio One account for everything crypto One account for old and new money'.tr),
    IntroSliderItem(
        Assets.images.intro2.path, 'Trade'.tr, 'Buy & Sell CryptocurrencyWe Provide Unlimited Crypto Liquidity Competitive Rates at Best Priceswith Minimum Slippage'.tr),
    IntroSliderItem(
        Assets.images.intro3.path, 'Withdraw profit'.tr, ' Decentralized Crypto Banking Platform Centralized Multi-Currency fiat wallet Comprehensive banking services'.tr),
    IntroSliderItem(Assets.images.intro4.path, 'Secure'.tr,
        'AkilaBanq is a Safe and Secure Way to Generate Right Yield on Your Digital Assets. You Meet Decentralization and Freedom in Your AkilaBanq Wallet'.tr),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Get.arguments == 'new_wallet'
          ? MainPagesToolbar(
              title: '',
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // if (Get.arguments != 'new_wallet')
            //   Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       children: [
            //         GestureDetector(
            //           onTap: controller.openLanguageSelector,
            //           child: const Icon(
            //             Icons.language_rounded,
            //             color: AppColors.accent,
            //             size: 30,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),

            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  IntroSliders(introItems: introItems),
                  GetBuilder<IntroPageController>(builder: (conti) {
                    return Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: conti.currentIntroIndex > 2 ? 1 : 0,
                        child: Column(
                          children: [
                            AppButton.long(
                                text: 'Create New Wallet'.tr,
                                iconData: Assets.icons.svg.riArrowRightLine,
                                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                onTap: controller.createNewWalletClickHandler),
                            AppButton.long(
                                textColor: AppColors.deepOrange,
                                text: 'Restore Wallet'.tr,
                                iconData: Assets.icons.svg.iconoirRefresh,
                                isReceive: true,
                                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                onTap: controller.restoreWalletClickHandler),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
