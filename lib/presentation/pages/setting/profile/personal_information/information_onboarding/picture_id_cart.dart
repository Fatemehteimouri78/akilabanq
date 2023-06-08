import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/setting/controller/information_onboarding_controller.dart';

import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PictureIdCart extends StatefulWidget {
  const PictureIdCart({Key? key}) : super(key: key);

  @override
  State<PictureIdCart> createState() => _PictureIdCartState();
}

class _PictureIdCartState extends State<PictureIdCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool captured=false;
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InformationOnboardingController>();

    return Scaffold(
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: Get.height / 3.7,
              alignment: Alignment.center,
              child: GetBuilder<InformationOnboardingController>(
                builder: (controller) {
                  return AspectRatio(
                      aspectRatio: 1.9/1,
                      child: !controller.cameraController.value.isInitialized
                          ? const Icon(Icons.warning)
                          : CameraPreview(controller.cameraController));
                }
              )),
          const Gap(20),
          const Text(
            "Does the photo of the front of your ID meet requirements?",
            style: AppTextStyles.dark_20_w500,
          ),
          const Gap(50),
          const IdCardCheckMark(
            text: "The ID is complete, clear, and not blurred.",
          ),
          const IdCardCheckMark(
            text:
            "The photo is not taken in the dark and there is no reflection of light.",
          ),
          const IdCardCheckMark(
            text: "The ID is not covered or damaged in any way.",
          ),
          const Spacer(),
         captured? Column(
           children: [
             AppButton.long(
                 text: "Yes looks Good",
                 iconData: Assets.icons.svg.riArrowRightLine,
                 onTap: () {
                   controller.nextPage();

                 }),
             const Gap(20)
             ,
             AppButton.long(
                 text: "Retake",
                 depth: 3,
                 onTap: () {
                   setState(() {
                     captured=false;
                   });
                 }),
           ],
         ):AppButton.long(
             text: "Capture",
             iconData: Assets.icons.svg.mny,
             textColor: Colors.deepOrange,
             onTap: () {
               setState(() {
                 captured=true;
               });
             }),
          const Gap(10)
        ],
      ),
    );
  }
}



class IdCardCheckMark extends StatelessWidget {
  const IdCardCheckMark({
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
          const CircleAvatar(
            radius: 2.5,
            backgroundColor: Colors.black,
          ),
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
