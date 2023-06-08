import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/setting/controller/information_onboarding_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constant/text_style.dart';
import '../../../../../../utils/cutom_neumero.dart';
import '../../../../../../utils/widgets/app_button.dart';

class BeforeIdCart extends StatelessWidget {
  const BeforeIdCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RoundReactNeumorophic(
            radius: BorderRadius.circular(10),
            isCircle: false,
            lightSource: LightSource.topLeft,
            depth: 4,
            child: Container(
              width: double.infinity,
              height: Get.height / 3.7,
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (p0, p1) {
                  return Container(
                      width: p1.maxWidth / 1.1,
                      height: p1.maxHeight / 1.1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage(Assets.images.identifyCard.path),
                              fit: BoxFit.cover)));
                },
              ),
            ),
          ),
          const Gap(20),
          const Text(
            "Before taking a photo of your ID card, make sure that:",
            style: AppTextStyles.dark_20_w500,
          ),
          const Gap(50),
          const IdentifyCheckMark(
            text: "This is vour real ID and it has not expired.",
          ),
          const IdentifyCheckMark(
            text: "Your ID is in good condition and not damaged",
          ),
          const IdentifyCheckMark(
            text:
                "The photo taken is clear, there is no light reflection, and the image is not blurry.",
          ),
          const Spacer(),
          GetBuilder<InformationOnboardingController>(builder: (controller) {
            return AppButton.long(
                text: "Take Photo",
                iconData: Assets.icons.svg.riArrowRightLine,
                onTap: () async {

                      controller.nextPage();
                });
          }),
          const Gap(10)
        ],
      ),
    );
  }
}

class IdentifyCheckMark extends StatelessWidget {
  const IdentifyCheckMark({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icons.svg.vector4),
          const Gap(20),
          Flexible(
            child: Text(
              text,
              style: AppTextStyles.dark_14_w300,
            ),
          ),
        ],
      ),
    );
  }
}
