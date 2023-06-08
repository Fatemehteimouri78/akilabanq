import 'package:akilabanq/presentation/pages/setting/controller/information_onboarding_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../utils/constant/color.dart';
import '../../../../../../utils/constant/text_style.dart';
import '../../../../../../utils/cutom_neumero.dart';
import '../../../../../../utils/widgets/app_button.dart';



class IdentityVerfication extends StatelessWidget {
  IdentityVerfication({
    Key? key,
  }) : super(key: key);
  final List<Widget> IntroOneText = [
    const IdentityVerficationWidget(
      textOne: "Personal Information ",
      index: 1,
      textTwo: "Must match information shown on ID",
    ),
    const IdentityVerficationWidget(
      textOne: "Photo of ID",
      index: 2,
      textTwo: "Provide a photo of your ID.",
    ),
    const IdentityVerficationWidget(
      textOne: "Face Verification",
      index: 3,
      textTwo: "Complete face verification .",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Indentity verification",
            style: AppTextStyles.dark_18_w700,
          ),
          const Gap(15),
          const Text(
            "To ensure security, you must complete Identity Verification by entering your personal information and uploading a photo of your ID. This process will take about 3 minutes",
            style: AppTextStyles.dark_14_w300,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) => IntroOneText[index]),
            ),
          ),
          RichText(
            text: TextSpan(
                text: "Please read the ",
                style: AppTextStyles.dark_12_w300.copyWith(height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: "User Identitv Verification Statement ",
                      style: AppTextStyles.dark_12_w300.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline)),
                  const TextSpan(text: "and "),
                  TextSpan(
                      text: "Jumio Privacy Policy ",
                      style: AppTextStyles.dark_12_w300.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline)),
                  const TextSpan(
                      text:
                          "to understand how your personal information and biometric data is collected and used for verification purposes. Then click the Continue button to indicate that you have read and agree to the statement and the policy.")
                ]),
          ),
          const Gap(30),
          GetBuilder<InformationOnboardingController>(
            builder: (controller) {
              return AppButton.long(
                  text: "Agree and continue",
                  iconData: Assets.icons.svg.riArrowRightLine,
                  onTap: () {
                    controller.nextPage();
                  });
            }
          ),
          const Gap(10)
        ],
      ),
    );
  }
}

class IdentityVerficationWidget extends StatelessWidget {
  const IdentityVerficationWidget({
    Key? key,
    required this.textOne,
    required this.textTwo,
    required this.index,
  }) : super(key: key);
  final String textOne;
  final String textTwo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundReactNeumorophic(
            isCircle: true,
            depth: .5,
            lightSource: LightSource.topLeft,
            radius: BorderRadius.zero,
            child: CircleAvatar(
              backgroundColor: AppColors.accent,
              child: GradientText((index + 1).toString(),
                  textScaleFactor: 1.4,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  colors: const [AppColors.orange, AppColors.deepOrange],
                  gradientDirection: GradientDirection.ttb),
            )),
        const Gap(20),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textOne,
              style: AppTextStyles.dark_14_w700,
            ),
            const Gap(5),
            Text(
              textTwo,
              style: AppTextStyles.dark_12_w300,
            )
          ],
        ),
      ],
    );
  }
}
