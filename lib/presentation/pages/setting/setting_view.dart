import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/setting/controller/setting_controller.dart';
import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../temp_test.dart';
import '../../../utils/constant/app_variable.dart';
import '../../../utils/constant/color.dart';
import '../../../utils/constant/text_style.dart';
import '../../../utils/cutom_neumero.dart';
import '../../../utils/widgets/app_link.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    Get.put(SettingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  MainPagesToolbar(title: "Setting"),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsetsDirectional.only(start: 36, end: 36, top: 65, bottom: 24),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                                radius: BorderRadius.circular(16),
                                child: InkWell(onTap: () => print("slaam"), child: _createSettingOption((Assets.icons.svg.walletActive), 'wallets'.tr))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                                radius: BorderRadius.circular(16),
                                child: InkWell(onTap: () => Get.toNamed(Routes.informationOnboarding), child: _createSettingOption((Assets.icons.svg.person), 'profile'.tr))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                              radius: BorderRadius.circular(16),
                              child: InkWell(
                                onTap: () => print("tapp"),
                                child: _createSettingOption(Assets.icons.svg.iconoirLanguage, 'language'.tr, value: const Text("En", style: AppTextStyles.greylight_14_w300)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                              radius: BorderRadius.circular(16),
                              child: InkWell(onTap: () => print("tapp"), child: _createSettingOption(Assets.icons.svg.tablerQuestionCircle, 'security_center'.tr)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                              radius: BorderRadius.circular(16),
                              child: _createSettingOption(
                                Assets.icons.svg.iconoirFingerprint,
                                'touch_id'.tr,
                                value: SizedBox(
                                    height: 28,
                                    child: (Switch(
                                      activeColor: AppColors.orange,
                                      value: false,
                                      onChanged: (value) => null,
                                    ))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                                radius: BorderRadius.circular(16), child: InkWell(onTap: null, child: _createSettingOption(Assets.icons.svg.iconoirInfoEmpty, 'about'.tr))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomNeumorophic(
                                radius: BorderRadius.circular(16), child: InkWell(onTap: null, child: _createSettingOption(Assets.icons.svg.settingActive, 'modify_pi_code'.tr))),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: AppLinkText(text: 'www.akilabanq.com', link: AppVariables.zarswapSite),
                      ),
                      const Text("Powered By LiquGate"),
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 16),
                        child: AppLinkText(text: 'www.LiquGate.com', link: AppVariables.talanSite),
                      ),
                      const Gap(100)
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                  height: 50,
                ),
                const Text('version ${AppVariables.appVersion}', textAlign: TextAlign.center, style: AppTextStyles.dark_12),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _createSettingOption(String icon, String label, {Widget? value, Color labelColor = AppColors.primaryDark}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
    child: Row(
      children: [
        SvgPicture.asset(icon, color: AppColors.primary2, width: 20),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.white_14.copyWith(color: labelColor)),
        const Expanded(child: SizedBox()),
        if (value != null) ...[
          value,
          const SizedBox(width: 6),
        ],
        // SvgPicture.asset(
        //   Assets.icons.svg.riArrowRightLine,
        //   width: 12,
        // )
      ],
    ),
  );
}

// Widget _createDivider() {
//   return Container(
//     height: 1,
//     margin: const EdgeInsets.symmetric(horizontal: 12),
//     color: AppColors.iconLightGrey,
//   );
// }
