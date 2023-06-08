import 'package:akilabanq/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(

      primaryColor: AppColors.materialLightPrimaryColor,
      scaffoldBackgroundColor: AppColors.bgColor,
      dialogBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      fontFamily: AppFonts.plusJakarta,
      textTheme: Get.textTheme.apply(
        displayColor: AppColors.extraLightGrey,
        bodyColor: AppColors.black.withOpacity(.4),
        fontFamily: AppFonts.plusJakarta,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent).copyWith(background: AppColors.bgColor));

// static final persianTheme = ThemeData(
//     cupertinoOverrideTheme:
//     MaterialAppCupertinoThemeDataOverrides(AppFonts.iranSans),
//     accentColor: AppColors.accent,
//     primaryColor: AppColors.accent,
//     primaryColorBrightness: Brightness.light,
//     backgroundColor: AppColors.defaultBg,
//     scaffoldBackgroundColor: AppColors.defaultBg,
//     dialogBackgroundColor: Colors.white,
//     canvasColor: Colors.white,
//     fontFamily: AppFonts.ibmPlex,
//     textTheme: Get.textTheme.apply(
//       displayColor: AppColors.accent,
//       bodyColor: AppColors.black.withOpacity(.4),
//       fontFamily: AppFonts.iranSans,
//     ),
//     bottomSheetTheme:
//     BottomSheetThemeData(backgroundColor: Colors.transparent));
}
