import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/wallet/controller/wallet_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/widgets/coint_cart.dart';
import 'package:akilabanq/presentation/pages/wallet/widgets/search_bar.dart';
import 'package:akilabanq/presentation/pages/wallet/widgets/wallet_card_page.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/widgets/app_toolbar.dart';
import 'widgets/carousel_card.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  void initState() {
    Get.put(WalletController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<WalletController>(builder: (controller) {
      return Scaffold(
        appBar: const AppToolbar(),
        body: controller.connectionFail.value
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'We have a Connection problem\n make sure you are connect to Internet\n and Try again.',
                    style: AppTextStyles.black_14_w500,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.getCoins(),
                    child: const Text('Try Again'),
                  )
                ],
              ))
            : controller.filteredToken.isEmpty
                ? Loading()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Column(
                      children: [
                        FadeInDownBig(
                          duration: const Duration(milliseconds: 600),
                          child: RoundReactNeumorophic(
                            isCircle: false,
                            depth: 7,
                            lightSource: const LightSource(-1, -2),
                            radius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: Get.height / 4.2,
                              decoration: BoxDecoration(
                                  color: AppColors.accent, borderRadius: BorderRadius.circular(10), image: DecorationImage(image: AssetImage(Assets.images.walletBg.path))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  WalletCardText(textOne: "TOTAL FIAT BALANCE", textTwo: "773.50.28 USD", textThree: "4233.324 EUR"),
                                  WalletCardText(textOne: "TOTAL CRYPTO BALANCE", textTwo: "773.50.28 USD", textThree: "4233.324 EUR  |  4233.324 AKL")
                                ],
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            showSearch(context: context, delegate: CustomSearchDelegate(tokens: controller.tokens));
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              textDirection: TextDirection.ltr,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    CupertinoIcons.search,
                                    color: AppColors.iconLightGrey,
                                  ),
                                ),
                                Text("Search")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.categories.length,
                                itemBuilder: (context, index) => CarouselCard(
                                  index: index,
                                ),
                              )),
                        ),

                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: FadeInLeft(
                        //         child: AppButton(
                        //           text: "Send",
                        //           iconData: Assets.icons.svg.send,
                        //           onTap: () => null,
                        //         ),
                        //       ),
                        //     ),
                        //     const Gap(20),
                        //     Expanded(
                        //       child: FadeInRight(
                        //         child: AppButton(
                        //           text: "Receive",
                        //           iconData: Assets.icons.svg.receive,
                        //           isReceive: true,
                        //           onTap: () => null,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Expanded(
                            child: controller.catChangeLoading.value
                                ? Center(
                                    child: Loading(),
                                  )
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(bottom: 80),
                                    itemBuilder: (context, index) => CoinCart(
                                      token: controller.filteredToken[index],
                                    ),
                                    itemCount: controller.filteredToken.length,
                                  ))
                      ],
                    ),
                  ),
      );
    });
  }
}
