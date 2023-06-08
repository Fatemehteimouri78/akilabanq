// import 'package:akilabanq/utils/constant/color.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// import '../../../../utils/constant/text_style.dart';
//
// class NeuTabBar extends StatelessWidget {
//   final bool isSelected;
//   final String text;
//
//
//   const NeuTabBar({super.key, this.isSelected = false,required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Neumorphic(
//         style: NeumorphicStyle(
//             depth: isSelected ? -3 : 1,
//             lightSource:const LightSource(-1, -1),
//             intensity: 1.9,
//             shadowLightColorEmboss: Colors.white.withAlpha(-1),
//             shadowDarkColorEmboss: AppColors.lightGrey.withOpacity(.6),
//             border: NeumorphicBorder(
//               color: Colors.grey.withOpacity(.01),
//             )),
//         child: Container(
//           alignment: Alignment.center,
//           height: 45,
//           color: AppColors.bgColor,
//           child: Text(
//             text,
//             style:isSelected? AppTextStyles.dark_14_w700:AppTextStyles.greylight_14_w500,
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:akilabanq/utils/constant/color.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../utils/constant/text_style.dart';

class NeuTabBar extends StatelessWidget {
  final bool isSelected;
  final String text;


  const NeuTabBar({super.key, this.isSelected = false,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: isSelected ? -3 : 3,
            intensity: .9,
            lightSource:const LightSource(-1, -1),
            shadowLightColorEmboss: Colors.white,surfaceIntensity: 20,
            shadowDarkColorEmboss: AppColors.lightGrey.withOpacity(.5),
            border: NeumorphicBorder(
              color: Colors.grey.withOpacity(.01),
            )),
        child: Container(
          alignment: Alignment.center,
          height: 45,
          color: AppColors.accent,
          child: Text(
            text,
            style:isSelected? AppTextStyles.dark_14_w700:AppTextStyles.greylight_14_w500,
          ),
        ),
      ),
    );
  }
}