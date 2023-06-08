import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/category/controller/category_controler.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget {
  CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final List<Widget> cardWidget = [
    const InvestmentAndFiftCard(
      investment: true,
    ),
    SupportAndHotel(isHotel: false),
    SupportAndHotel(isHotel: true),
    MobileTopUp(),
    const InvestmentAndFiftCard(investment: false),
  ];

  @override
  void initState() {
    super.initState();
    Get.put(CategoryController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainPagesToolbar(
          title: "Services",
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
          child: GridView.custom(
            shrinkWrap: true,
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 33,
              crossAxisSpacing: 30,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(3, 2),
                const QuiltedGridTile(1, 2),
                const QuiltedGridTile(1, 2),
                const QuiltedGridTile(3, 2),
                const QuiltedGridTile(2, 2),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(childCount: 5, (context, index) => cardWidget[index]),
          ),
        ));
  }
}

class MobileTopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeInRight(
      child: CustomNeumorophic(
        lightSource: const LightSource(-.9, -.9),
        opacity: .8,
        radius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20,
                  left: 13,
                  right: 13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.svg.mobile,
                      color: AppColors.deepOrange,
                    ),
                    const Gap(10),
                    const Text(
                      "Mobile Top-Up",
                      style: AppTextStyles.dark_14_w700,
                    ),
                    const Gap(10),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      style: AppTextStyles.dark_14_w300,
                    )
                  ],
                ),
              ),
              Positioned(
                  right: -8,
                  bottom: -3,
                  child: SvgPicture.asset(
                    Assets.icons.svg.mobile,
                    color: Colors.grey.shade400,
                    width: 50,
                    alignment: Alignment.bottomRight,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class InvestmentAndFiftCard extends StatelessWidget {
  final bool investment;

  const InvestmentAndFiftCard({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return investment
        ? FadeInLeft(
            child: CustomNeumorophic(
              lightSource: const LightSource(-.9, -.9),
              opacity: .8,
              radius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    investment
                        ? Positioned(
                            right: 0,
                            bottom: -4,
                            child: SvgPicture.asset(
                              Assets.icons.svg.chart,
                              color: Colors.grey.shade400,
                              width: 50,
                            ))
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 1,
                        left: 13,
                        right: 13,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            investment ? Assets.icons.svg.chart : Assets.icons.svg.tablerGiftCard,
                          ),
                          const Gap(10),
                          Text(
                            investment ? "Investment" : "Gift Cards",
                            style: AppTextStyles.dark_14_w700,
                          ),
                          const Gap(10),
                          Text(
                            investment
                                ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                                : "Lorem ipsum dolor sit amet, consectetur ",
                            style: AppTextStyles.dark_14_w300,
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : FadeInUp(
            child: CustomNeumorophic(
              lightSource: const LightSource(-.9, -.9),
              opacity: .8,
              radius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    investment
                        ? Positioned(
                            right: 0,
                            bottom: -4,
                            child: SvgPicture.asset(
                              Assets.icons.svg.chart,
                              color: Colors.grey.shade400,
                              width: 50,
                            ))
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 1,
                        left: 13,
                        right: 13,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            investment ? Assets.icons.svg.chart : Assets.icons.svg.tablerGiftCard,
                          ),
                          const Gap(10),
                          Text(
                            investment ? "Investment" : "Gift Cards",
                            style: AppTextStyles.dark_14_w700,
                          ),
                          const Gap(10),
                          Text(
                            investment
                                ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                                : "Lorem ipsum dolor sit amet, consectetur ",
                            style: AppTextStyles.dark_14_w300,
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class SupportAndHotel extends StatelessWidget {
  bool isHotel;

  SupportAndHotel({super.key, required this.isHotel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeInDown(
      child: CustomNeumorophic(
        lightSource: const LightSource(-.9, -.9),
        opacity: .8,
        radius: BorderRadius.circular(20),
        child: Container(
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(18),
                SvgPicture.asset(
                  isHotel ? Assets.icons.svg.materialSymbolsHotelOutlineRounded : Assets.icons.svg.headphone,
                  color: isHotel ? AppColors.primary2 : AppColors.deepOrange,
                ),
                const Gap(10),
                isHotel
                    ? const Text(
                        "Hotel Booking",
                        style: AppTextStyles.dark_14_w700,
                      )
                    : const Text(
                        "Support",
                        style: AppTextStyles.dark_14_w700,
                      ),
              ],
            )),
      ),
    );
  }
}
