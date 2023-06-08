import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/splash/controller/splash_controller.dart';
import 'package:akilabanq/utils/constant/sizes.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height - (MediaQuery.of(context).padding.top + kToolbarHeight + 140);
    screenWidth = size.width;
    presentHeight = screenHeight / 100;

    return GetBuilder<SplashController>(builder: (controller) {
      return Material(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: -190,
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(
                    8,
                    (index) => AnimatedBuilder(
                        animation: controller.animation.value.reactive,
                        child: RoundReactNeumorophic(
                          isCircle: true,
                          depth: index == 0 ? 0 : controller.animation.value,
                          lightSource: LightSource.topLeft,
                          radius: BorderRadius.zero,
                          child: Container(
                            color: Colors.white,
                            width: index == 1 ? index * 200 / 1.2 : index * 120 / 1.5,
                            height: index == 1 ? index * 200 / 1.2 : index * 140 / 1.5,
                            child: index == 1
                                ? Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: FadeInDown(duration: const Duration(milliseconds: 500), child: Image.asset(Assets.images.logo.path)),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        builder: (context, child) => child!),
                  ).reversed.toList(),
                )),
            Positioned(
              bottom: 100,
              child: FadeInUpBig(
                duration: const Duration(milliseconds: 600),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.images.logo.path,
                      width: 40,
                    ),
                    const Gap(10),
                    const Text(
                      "AkilaBanq",
                      style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              child: FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: const Text(
                  "Better Than Your Bank",
                  style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

// class Neumorophic extends StatelessWidget {
//   const Neumorophic({
//     Key? key,
//     required this.icon,
//     required this.onTap,
//     required this.padding,
//     required this.widget,
//   }) : super(key: key);
//   final String icon;
//   final Function onTap;
//   final double padding;
//   final Widget widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicButton(
//         curve: Curves.bounceIn,
//         provideHapticFeedback: true,
//         drawSurfaceAboveChild: true,
//         onPressed: () => onTap(),
//         style: NeumorphicStyle(
//           intensity: .9,
//           shadowLightColor: Colors.white,
//           shape: NeumorphicShape.concave,
//           shadowDarkColor: Colors.grey.shade500,
//           depth: 6,
//           surfaceIntensity: .7,
//           boxShape: NeumorphicBoxShape.circle(),
//         ),
//         padding: EdgeInsets.all(padding),
//         child: widget);
//   }
// }
}
