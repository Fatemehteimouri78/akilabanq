import 'package:akilabanq/presentation/pages/swap/models/pairs_model.dart';
import 'package:akilabanq/presentation/pages/swap/models/transfare_model.dart';
import 'package:akilabanq/presentation/pages/swap/transfare_page.dart';
import 'package:akilabanq/presentation/pages/swap/widgets/neu_tabbar.dart';
import 'package:akilabanq/presentation/pages/swap/widgets/pairs_search_bar.dart';
import 'package:akilabanq/presentation/pages/swap/widgets/transaction_card.dart';

import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/cached_image.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../gen/assets.gen.dart';
import '../wallet/send_token_view.dart';
import 'controller/swap_controler.dart';

const List<String> tabTitle = ["Swap", "Exchange", "Trade"];

class SwapView extends StatefulWidget {
  const SwapView({Key? key}) : super(key: key);

  @override
  State<SwapView> createState() => _SwapViewState();
}

class _SwapViewState extends State<SwapView> {
  @override
  void initState() {
    Get.put(SwapController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MainPagesToolbar(title: "Swap"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(children: [
            DefaultTabController(
                length: 3,
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(border: Border.all(color: Colors.transparent)),
                  physics: const NeverScrollableScrollPhysics(),
                  tabs: List.generate(
                    3,
                    (index) => GetBuilder(
                        init: SwapController(),
                        builder: (controller) {
                          return Tab(
                            child: GestureDetector(
                                onTap: () {
                                  print(index.toString());
                                  controller.topBarChangeTab(index);
                                  if (kDebugMode) {
                                    print("${index}index");
                                  }
                                },
                                child: NeuTabBar(
                                  text: tabTitle[index],
                                  isSelected: index == controller.currentTab ? true : false,
                                )),
                          );
                        }),
                  ),
                )),
            Expanded(
              child: GetBuilder(
                  init: SwapController(),
                  builder: (controller) {
                    return controller.pageLoading.value
                        ? Center(
                            child: Loading(),
                          )
                        : PageView.builder(
                            controller: controller.topTabController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                  color: AppColors.bgColor,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
                                        child: RoundReactNeumorophic(
                                          depth: 4,
                                          isCircle: false,
                                          lightSource: const LightSource(-1, -1),
                                          radius: BorderRadius.circular(7),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: Get.height / 3.5,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SwapTopCardDetail(
                                                  leftOne: "YOU PAY",
                                                  youPayField: true,
                                                  currentPair: controller.currentPair,
                                                  controller: controller,
                                                ),
                                                Stack(
                                                  alignment: Alignment.centerRight,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    const Divider(
                                                      color: AppColors.lightGrey,
                                                    ),
                                                    Positioned(
                                                        right: 20,
                                                        child: RoundReactNeumorophic(
                                                            isCircle: true,
                                                            radius: BorderRadius.zero,
                                                            depth: 3,
                                                            child: CircleAvatar(
                                                              radius: 23,
                                                              backgroundColor: AppColors.bgColor,
                                                              child: SvgPicture.asset(Assets.icons.svg.swapp),
                                                            )))
                                                  ],
                                                ),
                                                SwapTopCardDetail(
                                                  leftOne: "You Get",
                                                  youPayField: false,
                                                  currentPair: controller.currentPair,
                                                  controller: controller,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      AppButton.long(
                                        text: "Swap",
                                        iconData: Assets.icons.svg.riArrowRightLine,
                                        onTap: () {
                                          if (controller.valueController.text.isNotEmpty && !controller.currentPair.isNull) {
                                            Get.to(  TransfarePage(

                                              transfare: TransfareModel(
                                                  type: 'Exchange',
                                                  tokenName: controller.currentPair.senderName!,
                                                  tokenSym: controller.currentPair.senderSym!,
                                                  balance: controller.valueController.text,
                                                  price: 35.0,

                                                  fromAddress: controller.currentPair.senderAddress!,
                                                  toAddress: controller.currentPair.receiverAddress!,
                                                  callBack: () {

                                                    if(double.parse(controller.valueController.text) > controller.currentPair.senderBalance!){
                                                      showWarningToast('The entered balance is greater than your amount');
                                                    }else {
                                                      controller.exchange();
                                                    }
                                                  }),
                                            ));
                                          } else {
                                            showWarningToast("please Enter Your Balance value");
                                          }
                                        },
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      //   child: TabBar(
                                      //       onTap: (value) {
                                      //         controller.bTabchage(value);
                                      //       },
                                      //       controller: controller.bottomTabController,
                                      //       indicatorColor: AppColors.deepOrange,
                                      //       indicatorWeight: .8,
                                      //       labelPadding: EdgeInsets.zero,
                                      //       padding: EdgeInsets.zero,
                                      //       indicatorSize: TabBarIndicatorSize.label,
                                      //       labelColor: AppColors.deepOrange,
                                      //       unselectedLabelColor: AppColors.lightGrey,
                                      //       tabs: [
                                      //         controller.bottomTabController.index == 0
                                      //             ? GradientText('Only USD to AKL',
                                      //             colors: const [AppColors.orange, AppColors.deepOrange],
                                      //             gradientType: GradientType.linear,
                                      //             gradientDirection: GradientDirection.ttb)
                                      //             : const Text('Only USD to AKL'),
                                      //         controller.bottomTabController.index == 1
                                      //             ? GradientText('All Orders',
                                      //             colors: const [AppColors.orange, AppColors.deepOrange],
                                      //             gradientType: GradientType.linear,
                                      //             gradientDirection: GradientDirection.ttb)
                                      //             : const Text('All Orders'),
                                      //       ]),
                                      // ),
                                      Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: controller.exchanges.length,
                                            itemBuilder: (context, index) => TransActionCard(
                                                  index: index,
                                                  exchange: controller.exchanges[index],
                                                )),
                                      ),
                                    ],
                                  ));
                            },
                          );
                  }),
            )
          ]),
        ));
  }
}

class SwapTopCardDetail extends StatelessWidget {
  const SwapTopCardDetail({
    Key? key,
    required this.leftOne,
    required this.youPayField,
    required this.currentPair,
    required this.controller,
  }) : super(key: key);
  final String leftOne;

  final bool youPayField;
  final PairsModel currentPair;
  final SwapController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftOne,
                style: AppTextStyles.dark_14_w500,
              ),
              const Gap(10),
              youPayField
                  ? Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 120,
                          child: FormBuilderTextField(
                            name: 'amount',
                            // textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            controller: controller!.valueController,



                            onChanged: (value) {
                              controller.getEstimate(value!);
                            },
                            style: AppTextStyles.dark_16_w700,

                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                            ],
                            decoration: const InputDecoration(
                              hintText: '0',

                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(0),
                              hintStyle: AppTextStyles.greylight_16_w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : Obx(
                      () => controller.updatingEstimate.value
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Loading(
                                alignment: Alignment.centerLeft,
                              ))
                          : Text(
                              controller.currentEstimate.value.toString(),
                              style: AppTextStyles.dark_16_w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
              const Gap(10),
              Text(
                'balance: ${youPayField ? currentPair.senderBalance.toString() : currentPair.receiverBalance.toString()}',
                style: AppTextStyles.greylight_14_w300,
              )
            ],
          )),
          InkWell(
            onTap: () {
              showSearch(context: context, delegate: PairsSearchDelegate(pairs: controller.fromPairs , isFromPair: youPayField));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cachedImage(youPayField ? currentPair.senderIcon : currentPair.receiverIcon, height: 25),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  youPayField ? currentPair.senderSym.toString() : currentPair.receiverSym.toString(),
                  style: AppTextStyles.dark_16_w700,
                ),
                const Gap(10),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 15,
                  color: AppColors.deepOrange,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
