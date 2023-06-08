import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../utils/constant/color.dart';
import '../../../../../../utils/constant/text_style.dart';
import '../../../../../../utils/cutom_neumero.dart';
import '../../../../../../utils/widgets/app_button.dart';

class FaceVerfication extends StatelessWidget {
  FaceVerfication({
    Key? key,
  }) : super(key: key);
  final List<Widget> IntroOneText = [
    const FaceVerficationWidget(
      textOne: "Do not cover your face. ",
      index: 1,
    ),
    const FaceVerficationWidget(
      textOne: "Do not wear a hat.",
      index: 2,
    ),
    const FaceVerficationWidget(
      textOne:
          "Make sure the environment has soft lighting, o- there are no reflections, and it is not too dark.",
      index: 3,
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
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) => IntroOneText[index]),
            ),
          ),
          const Spacer(flex: 2,),


          const Gap(30),
          AppButton.long(
              text: "Start",
              iconData: Assets.icons.svg.riArrowRightLine,
              onTap: () {}),
          const Gap(10)
        ],
      ),
    );
  }
}

class FaceVerficationWidget extends StatelessWidget {
  const FaceVerficationWidget({
    Key? key,
    required this.textOne,
    required this.index,
  }) : super(key: key);
  final String textOne;

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
        Expanded(
          child: Text(
            textOne,
            style: AppTextStyles.dark_14_w700,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
