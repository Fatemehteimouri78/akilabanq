import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/services/localization/localization_service.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/controllers/global_controller.dart';
import 'package:akilabanq/utils/logger.dart';
import 'package:akilabanq/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.darkGrey, statusBarIconBrightness: Brightness.light));
  await GetStorage.init();
  Get.put(GlobalController(), permanent: true);

  runApp(GetMaterialApp(
    title: 'AkilaBanq',
    getPages: AppPages.routes,
    initialRoute: AppPages.initial,
    debugShowCheckedModeBanner: false,
    theme: AppThemes.lightTheme,
    enableLog: true,
    logWriterCallback: Logger.write,
    locale: TranslationService.locale,
  ));
}
