import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../gen/assets.gen.dart';
import '../constant/color.dart';

class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  const AppToolbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTitle(
              rtl: false,
            ),
            SvgPicture.asset(Assets.icons.svg.tablerBell)
          ],
        ),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  bool rtl;

  AppTitle({super.key, required this.rtl});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(textDirection: TextDirection.ltr, children: [
      Text(
        'Akila',
        style: AppTextStyles.white_20_w700.copyWith(color: AppColors.black, fontSize: 23),
      ),
      GradientText(
        'Banq',
        colors: const [AppColors.orange, AppColors.deepOrange],
        gradientType: GradientType.linear,
        gradientDirection: GradientDirection.ttb,
        style: AppTextStyles.white_20_w700.copyWith(color: AppColors.black, fontSize: 23),
      )
    ]);
  }
}
