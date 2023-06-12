import 'dart:async';

import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/home/controller/home_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/controller/token_transactions_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_price.dart';
import 'package:akilabanq/presentation/pages/wallet/model/transactios.dart';
import 'package:akilabanq/presentation/pages/wallet/widgets/transition_cart.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/widgets/cached_image.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenTransactions extends StatefulWidget {
  const TokenTransactions({super.key});

  @override
  State<TokenTransactions> createState() => _TokenTransactionsState();
}

class _TokenTransactionsState extends State<TokenTransactions> {

  late Timer timer;
  @override
  void initState() {
    TokenTransactionController controller =  Get.find<TokenTransactionController>();
    timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      controller.setTokenModel(controller.currentToken,showLoading: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<HomeController>().changePageIndex(2);
        return false;
      },
      child: GetX<TokenTransactionController>(builder: (controller) {
        TokenModel token = controller.currentToken;
        return Scaffold(
          appBar: MainPagesToolbar(
            title: token.name,
            gotLeading: true,
            leadingCallBack: () =>
                Get.find<HomeController>().changePageIndex(2),
            actions: [SvgPicture.asset(Assets.icons.svg.tokenDetailAction)],
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: controller.loading.value
                ? Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Loading(),
            )
                : Column(
              children: [
                BnbHeaderWidget(
                    token: token, balance: controller.currentBalance!.value, tokenPrice: controller.tokenPrice,),
                BnbButtonsWidget(
                  token: token,
                ),
                BnbTabbar(),
                controller.transactions.isEmpty
                    ? const Center(
                  child: Text("No Transaction Exist."),
                )
                    : Expanded(
                  child: Obx(() {
                    final transactions = <TransactionModel>[];
                    transactions.addAll(controller.transactions);
                    if(controller.currentIndex.value == 2){
                      transactions.removeWhere((element) => element.type == "send");
                    }else if(controller.currentIndex.value == 1){
                      transactions.removeWhere((element) => element.type != "send");
                    }
                    return RefreshIndicator(
                      onRefresh: () async{
                        controller.setTokenModel(controller.currentToken);
                      },
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 200),
                        children: [
                          for (var i = 0;
                          i < transactions.length;
                          i++)
                            TransitionCart(
                                transition: transactions[i])
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class BnbTabbar extends StatefulWidget {
  @override
  State<BnbTabbar> createState() => _BnbTabbarState();
}

class _BnbTabbarState extends State<BnbTabbar> {
  List<String> buttons = ['All', 'Send', 'Receive'];

  int tappedCategory = 0;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.extraLightGrey, width: 0.5))),
      child: Row(
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedCategory = i;
                      Get.find<TokenTransactionController>().currentIndex.value = i;
                    });
                  },
                  child: Text(
                    buttons[i],
                    style: tappedCategory == i
                        ? AppTextStyles.blue_14_w600
                        .copyWith(decoration: TextDecoration.underline)
                        : AppTextStyles.greylight_14_w300,
                  )),
            ),
        ],
      ),
    );
  }
}

class BnbButtonsWidget extends StatelessWidget {
  BnbButtonsWidget({
    super.key,
    required this.token,
  });

  final TokenModel token;
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bnbButton('Send', Assets.icons.svg.send,
                  () => controller.changePageIndex(7)),
          bnbButton('Recieve', Assets.icons.svg.greenRecieve,
                  () => controller.changePageIndex(6)),
          bnbButton('Buy', Assets.icons.svg.buy, () => print('buy')),
          bnbButton('Swap', Assets.icons.svg.swap, () => print('swap'))
        ],
      ),
    );
  }

  InkWell bnbButton(String title, String icon, VoidCallback callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 69,
        width: 69,
        child: RoundReactNeumorophic(
            radius: BorderRadius.circular(10),
            depth: 7,
            isCircle: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  title,
                  style: AppTextStyles.black_11_w600,
                ),
              ],
            )),
      ),
    );
  }
}

class BnbHeaderWidget extends StatelessWidget {
  const BnbHeaderWidget(
      {super.key, required this.token, required this.balance, required this.tokenPrice});

  final TokenPrice? tokenPrice;
  final TokenModel token;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return FadeInDownBig(
        child: RoundReactNeumorophic(
          isCircle: false,
          depth: 7,
          lightSource: const LightSource(-1, -2),
          radius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(token.type.toUpperCase()),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          '\$${tokenPrice?.price}',
                          style: AppTextStyles.greylight_14_w300,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_left,
                          color: AppColors.tightRed,
                        ),
                        Text(
                          "${tokenPrice?.priceChangePercent}",
                          style: AppTextStyles.dark_14_w300
                              .copyWith(color: AppColors.tightRed),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 53,
                      width: 53,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: cachedImage(token.icon, boxFit: BoxFit.fill),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            balance.isNull
                                ? Loading()
                                : Text(
                              '${balance ?? 0.0} ',
                              style: AppTextStyles.black_20_w700,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              token.symbol,
                              style: AppTextStyles.black_20_w700,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '\$${token.tokenValue}',
                          style: AppTextStyles.greylight_14_w300,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
