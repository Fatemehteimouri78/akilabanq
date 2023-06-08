import 'package:akilabanq/presentation/pages/splash/controller/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/constant/color.dart';
import '../../../utils/constant/text_style.dart';
import '../../../utils/cutom_neumero.dart';

class IntroSliders extends StatefulWidget {
  final List<IntroSliderItem> introItems;

  const IntroSliders({required this.introItems});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IntroSliders> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntroPageController());
    final size = MediaQuery.of(context).size;
    return GetBuilder<IntroPageController>(builder: (controller) {
      return Column(
        children: [
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: controller.introController,
              onPageChanged: (value) {
                controller.changeintroIndex(value);
              },

              children: widget.introItems.map((slider) {
                return Column(
                  children: [
                    const Gap(60),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        RoundReactNeumorophic(
                            isCircle: true,
                            radius: BorderRadius.circular(30),
                            padding: 10,
                            depth: 8,
                            child: const CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                            )),
                        Image.asset(slider.imageAsset,
                            color: AppColors.primary2, width: 190)
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(slider.title, style: AppTextStyles.dark_20),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 74),
                      child: Text(slider.description,
                          style: AppTextStyles.greylight_14,
                          textAlign: TextAlign.center),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: _createPreviousBtn()),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: SmoothPageIndicator(
                    controller: controller.introController,
                    count: widget.introItems.length,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth: 8.0,
                        dotHeight: 8.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 0,
                        dotColor: Colors.grey.withOpacity(.2),
                        activeDotColor: AppColors.deepOrange.withOpacity(.8)),
                  ),
                ),
                Positioned(
                  right: -55,
                  bottom: -46,
                  child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: _createNextBtn()),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _createPreviousBtn() {
    return GetBuilder<IntroPageController>(builder: (context) {
      return GestureDetector(
          onTap: () => context.previousPage(),
          child: const Icon(Icons.arrow_back, color: AppColors.black));
    });
  }

  Widget _createNextBtn() {
    return GetBuilder<IntroPageController>(builder: (context) {
      return GestureDetector(
          onTap: () => context.nextpage(),
          child: GetBuilder<IntroPageController>(builder: (context) {
            return context.currentIntroIndex < 3
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      RoundReactNeumorophic(
                          isCircle: true,
                          depth: context.currentIntroIndex < 3 ? 4 : 0,
                          radius: BorderRadius.zero,
                          child: const CircleAvatar(
                              radius: 65, backgroundColor: Colors.transparent)),
                      const Icon(Icons.arrow_forward, color: AppColors.black),
                      context.currentIntroIndex < 3
                          ? const Positioned(
                              top: -10,
                              right: 70,
                              child: CircleAvatar(
                                backgroundColor: AppColors.primary2,
                                radius: 13,
                              ))
                          : const SizedBox(),
                    ],
                  )
                : const SizedBox();
          }));
    });
  }
}

class IntroSliderItem {
  final String imageAsset;
  final String title;
  final String description;

  IntroSliderItem(this.imageAsset, this.title, this.description);
}
