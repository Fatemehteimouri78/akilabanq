import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../utils/constant/color.dart';
import '../../../../utils/constant/text_style.dart';
import '../../../../utils/cutom_neumero.dart';
import '../home_view.dart';

class WalletTap extends StatelessWidget {
  BottomModel bottomModel;
  bool isActive;

  WalletTap({super.key, required this.bottomModel, required this.isActive});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Gap(10),
          RoundReactNeumorophic(
            radius: BorderRadius.zero,
            depth: 1.9,
            lightSource: const LightSource(-.4, -.4),
            isCircle: true,
            borderWidth: 3,
            borderColor: Colors.white.withOpacity(.19),
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 35,
              child: SvgPicture.asset(
                isActive ? bottomModel.activeIcon : bottomModel.inActiveIcon,
                color: isActive ? Colors.deepOrange : AppColors.iconDarkGrey,),
            ),
          ),
          const Gap(10),
          Text(
            "WALLET".tr,
            style: AppTextStyles.greylight_12_w300
                .copyWith(
                fontWeight: FontWeight.w800,  fontSize: 13, letterSpacing: 1.5),
          )
        ],
      ),
    );
  }
}