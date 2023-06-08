import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/trade/controller/trade_controller.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TradeView extends StatefulWidget {
  const TradeView({Key? key}) : super(key: key);

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  @override
  void initState() {
    Get.put(TradeViewController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPagesToolbar(title: "Services and Limits", actions: [
        SvgPicture.asset(
          Assets.icons.svg.tablerQuestionCircle,
          color: AppColors.black,
        ),
        SvgPicture.asset(
          Assets.icons.svg.headphone,
          color: AppColors.black,
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Services",
              style: AppTextStyles.greylight_16_w700,
            ),
            const Gap(25),
            CurrentServices(
              firstText: "Withdrawals",
              iconData: Assets.icons.svg.tablerArrowUpRightCircle,
              secondText: "1 BTC per day",
              defaultColor: false,
            ),
            CurrentServices(
              firstText: "P2P Trading",
              iconData: Assets.icons.svg.tradeActive,
              secondText: "2,000 USD per day",
              defaultColor: false,
            ),
            CurrentServices(
              firstText: "Fiat Deposits ",
              iconData: Assets.icons.svg.tablerCashBanknote,
              secondText: "Unavailable ",
              defaultColor: false,
            ),
            const Gap(30),
            RoundReactNeumorophic(
              radius: BorderRadius.circular(10),
              depth: 3,
              isCircle: false,
              lightSource: LightSource.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: double.infinity,
                height: Get.height / 2.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "All Services",
                      style: AppTextStyles.dark_18_w500.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Gap(6),
                    const Text(
                      "Provide a photo of your ID and complete face verification (3-4 minutes).",
                      style: AppTextStyles.greylight_14_w300,
                    ),
                    const Gap(6),
                    const Divider(
                      color: AppColors.lightGrey,
                    ),
                    const Gap(6),
                    CurrentServices(
                      firstText: "Withdrawals",
                      iconData: Assets.icons.svg.tablerArrowUpRightCircle,
                      secondText: "200 BTC per day",
                    ),
                    CurrentServices(
                      firstText: "P2P Trading",
                      iconData: Assets.icons.svg.trd,
                      secondText: "500,000 USD per day",
                    ),
                    CurrentServices(
                      firstText: "Fiat Deposits ",
                      iconData: Assets.icons.svg.tablerCashBanknote,
                      secondText: "Available   ",
                    ),
                    const Spacer(),
                    AppButton.long(
                      text: "Verify",
                      onTap: () {},
                      iconData: Assets.icons.svg.riArrowRightLine,
                    )
                  ],
                ),
              ),
            ),
            // Gap(4),
            // Text("For institutional users, complete the verification on a PC. ",style: AppTextStyles.light_12,)
          ],
        ),
      ),
    );
  }
}

class CurrentServices extends StatelessWidget {
  const CurrentServices({super.key, required this.iconData, required this.firstText, required this.secondText, this.defaultColor = true});

  final String iconData;
  final String firstText;
  final String secondText;
  final bool defaultColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              defaultColor
                  ? SvgPicture.asset(
                      iconData,
                      color: AppColors.deepOrange,
                    )
                  : SvgPicture.asset(
                      iconData,
                      color: AppColors.black,
                    ),
              const Gap(7),
              Text(
                firstText,
                style: AppTextStyles.dark_14_w500.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text(
            secondText,
            style: AppTextStyles.greylight_14_w300,
          ),
        ],
      ),
    );
  }
}
