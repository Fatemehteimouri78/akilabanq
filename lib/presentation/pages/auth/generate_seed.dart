import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/auth/widgets.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utils/constant/color.dart';
import '../../../utils/constant/text_style.dart';
import '../../../utils/widgets/custom_checkBox.dart';
import 'controller/generate_seed.dart';

class GenerateSeedsPage extends GetView<GenerateSeedsPageController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              IntroPagesToolbar(title: 'Backup seed words'.tr),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text('warning!'.tr, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          'please copy and keep it in a safe place. the seed words is the only way to restore your wallet .once lost it cannot be retrived. Do not use screenshots,photos,etc to save'
                              .tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.greylight_14.copyWith(wordSpacing: 1, height: 1.5, overflow: TextOverflow.clip)),
                    ),
                    const SizedBox(height: 40),
                    GetX<GenerateSeedsPageController>(builder: (controller) {
                      return controller.seeds.isEmpty
                          ? Loading()
                          : AppSeedWordsSelector(
                              seeds: controller.seeds,
                              selectedSeeds: const [],
                              onSelection: (value) => {},
                            );
                    }),
                    const SizedBox(height: 20),
                    AppCheckBox(
                      onChange: controller.understandCheckBoxChangeHandler,
                      label: 'i understand that if i lose my seed words , no one can help me recover. i will never be able to retrieve the assest in my wallet.'.tr,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppCheckBox(
                      onChange: controller.agreeCheckBoxChangeHandler,
                      label: 'please read and agree to the agreement first. '.tr,
                      getTermsText: true,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: AppLinkText(
                    //       text: 'terms_of_service'.tr,
                    //       link: AppVariables.zarTermsSite,
                    //       fontSize: 14),
                    // ),
                  ],
                ),
              ),
              const Spacer(),
              //SizedBox(height: 16,),

              Column(
                children: [
                  AppButton.long(
                    text: 'Backed up Words'.tr,
                    textColor: AppColors.primary2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    iconData: Assets.icons.svg.riArrowRightLine,
                    onTap: (){
                      controller.seeds.length == 12 ? controller.verifyForm() : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AppButton.long(
                      textColor: AppColors.orange,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      iconData: Assets.icons.svg.iconoirRefresh,
                      text: 'Regenerate'.tr,
                      onTap: controller.generateSeedWords),
                ],
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
