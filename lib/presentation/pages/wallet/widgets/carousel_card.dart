import 'package:akilabanq/presentation/pages/wallet/controller/wallet_controller.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return GetX<WalletController>(builder: (controller) {
      return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        margin: EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            controller.category = controller.categories[index];
            controller.changeCategory( index);
          },
          child: RoundReactNeumorophic(
            depth: controller.currentCategory.value == index ? -3 : 3,
            isCircle: false,
            radius: BorderRadius.circular(10),
            lightSource: const LightSource(-1.5, -1),
            // style: NeumorphicStyle(
            //     color: AppColors.F0F0F3,
            //     depth: controller.currentCategory.value == index ? -3 : 3,
            //     intensity: .9,
            //     lightSource: const LightSource(-1.5, -1),
            //     // shadowLightColorEmboss: Colors.white,
            //     // surfaceIntensity: 20,
            //     // shadowDarkColorEmboss: AppColors.grey3.withOpacity(.5),
            //     border: NeumorphicBorder(
            //       color: controller.currentCategory.value == index ? AppColors.deepOrange : Colors.grey.withOpacity(.01),
            //     )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: Text(
                controller.categories[index],
                style: TextStyle(fontSize: 14, color: controller.currentCategory.value == index ? AppColors.deepOrange : AppColors.iconLightGrey),
              ),
            ),
          ),
        ),
      );
    });
  }
}


//  BoxDecoration(
//               border: Border.all(color: controller.currentCategory.value == index ? AppColors.deepOrange : AppColors.iconLightGrey),
//               borderRadius: BorderRadius.circular(10),
//               color: controller.currentCategory.value == index ? Colors.white : Colors.transparent),