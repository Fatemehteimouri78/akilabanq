import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utils/constant/color.dart';

class WalletCardText extends StatelessWidget {
  String textOne;
  String textTwo;
  String textThree;

  WalletCardText(
      {super.key,
        required this.textOne,
        required this.textTwo,
        required this.textThree});

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textOne,
          style: AppTextStyles.greylight_10_w500.copyWith(fontSize: 10.2),
        ),
        const Gap(5),
        Text(textTwo,
            style: AppTextStyles.greylight_20_w700
                .copyWith(color: AppColors.primary2)),
        const Gap(5),
        Text(
          textThree,
          style:
          AppTextStyles.greylight_10_w500.copyWith(color: AppColors.black,fontSize: 10.2),
        ),
      ],
    );
  }
}
