import 'package:akilabanq/presentation/pages/setting/controller/information_onboarding_controller.dart';
import 'package:akilabanq/presentation/pages/setting/profile/personal_information/information_onboarding/personal_information.dart';
import 'package:akilabanq/presentation/pages/setting/profile/personal_information/information_onboarding/picture_id_cart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../utils/constant/color.dart';
import 'information_onboarding/before_id_cart.dart';
import 'information_onboarding/face_verfication.dart';
import 'information_onboarding/identity_verfication.dart';

class InformationOnboarding extends GetView<InformationOnboardingController> {
  InformationOnboarding({Key? key}) : super(key: key);
  List<Widget> pages = [
    PersonalInforfmation(),
    IdentityVerfication(),
     const BeforeIdCart(),
    const PictureIdCart(),
    FaceVerfication(),



  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformationOnboardingController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  Assets.icons.svg.lftq,
                ),
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: pages.length,
                  axisDirection: Axis.horizontal,
                  effect: SwapEffect(
                      type: SwapType.yRotation,
                      spacing: 8.0,
                      radius: 4.0,
                      dotWidth: 50.0,
                      dotHeight: 4.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 0,
                      dotColor: Colors.grey.withOpacity(.2),
                      activeDotColor: AppColors.deepOrange.withOpacity(.8)),
                ),
                const SizedBox()
              ],
            ),
          ),
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemCount: pages.length,
            onPageChanged: (value) {
            },
            itemBuilder: (context, index) {
              return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
                child: pages[controller.currentIndex],
              );
            },
          ),
        );
      }
    );
  }
}