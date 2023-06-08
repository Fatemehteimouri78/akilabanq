import 'package:akilabanq/presentation/pages/auth/controller/verify_seed_controller.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/typedef.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../utils/constant/color.dart';
import '../../../utils/constant/text_style.dart';
import 'package:get/get.dart';

class AppSeedWordsSelector extends StatelessWidget {
  final List<String> seeds;
  final List<String> selectedSeeds;
  final StringCallback onSelection;

  const AppSeedWordsSelector({
    required this.seeds,
    required this.selectedSeeds,
    required this.onSelection,
  });
  final bool _unelected = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (seeds.length < 12) {
      throw Exception('seeds count must be at least 12');
    }
    final words = seeds.take(12).toList();
    final threeLists = words.split(4).toList();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: size.width * 0.8,
        child: Column(
          children: [
            for (var list in threeLists) _createWordsRow(list),
          ],
        ),
      ),
    );
  }

  Widget _createWordsRow(List<String> row) {
    bool x = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var word in row)
          GestureDetector(
            onTap: () => onSelection(word),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Neumorphic(
                style: NeumorphicStyle(
                    color: AppColors.F0F0F3,
                    depth: selectedSeeds.contains(word) ? -3 : 3,
                    intensity: .9,
                    lightSource: const LightSource(-1, -1),
                    shadowLightColorEmboss: Colors.white,
                    surfaceIntensity: 20,
                    shadowDarkColorEmboss: AppColors.grey3.withOpacity(.5),
                    border: NeumorphicBorder(
                      color: Colors.grey.withOpacity(.01),
                    )),
                // NeumorphicStyle(
                //     disableDepth: selectedSeeds.contains(
                //       word,
                //     ),
                //     color: AppColors.accent,
                //     intensity: selectedSeeds.contains(word) ? 0 : 1,
                //     shape: NeumorphicShape.concave),
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: selectedSeeds.contains(word) ? AppColors.accent : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      word,
                      style: selectedSeeds.contains(word) ? AppTextStyles.dark_14_w300 : AppTextStyles.black_14_w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class AppSeedWordsArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<VerifySeedsPageController>(builder: (controller) {
      final words = controller.selectedSeeds.take(12).toList();
      final threeLists = words.split(4).toList();

      return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: size.width / 0.8,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [for (var row in threeLists) _createWordsRow(row, controller)],
          ),
        ),
      );
    });
  }

  Widget _createWordsRow(List<String> row, VerifySeedsPageController controller) {
    bool x = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var word in row)
          GestureDetector(
            onTap: () => controller.deleteCurrentSeedWord(word),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Neumorphic(
                style: NeumorphicStyle(
                  depth: 3,
                  color: AppColors.F0F0F3,
                  intensity: 0.9,
                  surfaceIntensity: 20,
                  shadowDarkColorEmboss: AppColors.grey3.withOpacity(.5),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      word,
                      style: AppTextStyles.black_14_w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
