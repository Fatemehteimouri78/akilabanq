import 'package:akilabanq/presentation/pages/auth/controller/verify_seed_controller.dart';
import 'package:akilabanq/presentation/pages/auth/widgets.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifySeedsPage extends GetView<VerifySeedsPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VerifySeedsPageController>(builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [
                IntroPagesToolbar(title: 'Confirm backup'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('warning!'.tr, textDirection: TextDirection.ltr, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      'please copy and keep it in a safe place. the seed words is the only way to restore your wallet .once lost it cannot be retrived. Do not use screenshots,photos,etc to save'
                          .tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.greylight_14.copyWith(wordSpacing: 1, height: 1.5, overflow: TextOverflow.clip)),
                ),
                const SizedBox(height: 35),
                Flexible(flex: 2, child: FittedBox(fit: BoxFit.scaleDown,child: AppSeedWordsArea())),
                const SizedBox(
                  height: 16,
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                AppSeedWordsSelector(
                  seeds: controller.shuffledSeeds,
                  selectedSeeds: controller.selectedSeeds,
                  onSelection: controller.onSelectedSeedsChangeHandler,
                ),
                const Spacer(),
                AppButton.long(text: 'Confirm'.tr, onTap: controller.requestWalletGeneration, child: controller.createWalletLoading.value ? Loading() : null)
              ],
            ),
          ),
        );
      }),
    );
  }
}
