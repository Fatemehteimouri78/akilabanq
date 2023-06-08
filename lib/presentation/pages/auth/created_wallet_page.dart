import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/auth/controller/verify_seed_controller.dart';
import 'package:akilabanq/presentation/pages/auth/widgets.dart';
import 'package:akilabanq/presentation/pages/splash/intro.dart';
import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatedWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntroPagesToolbar(title: 'Create New Wallet'.tr),
            Column(
              children: [
                Center(
                  child: Container(
                    child: Image.asset(Assets.images.intro5.path),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Wallet Created',
                  style: AppTextStyles.black_14_w500.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Please keep your security keys and passwords\n in a safe place.',
                  style: AppTextStyles.greylight_14_w300,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // const Spacer(),
            AppButton.long(
              text: 'Access Your Wallet'.tr,
              onTap: () => Get.offAllNamed(Routes.home),
            )
          ],
        ),
      ),
    ));
  }
}
