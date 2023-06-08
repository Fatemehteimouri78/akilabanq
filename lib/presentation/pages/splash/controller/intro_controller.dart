import 'package:akilabanq/utils/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';


import '../../../../utils/constant/app_keys.dart';
import '../../../../utils/controllers/global_controller.dart';
import '../../../../utils/secure_storage.dart';
import '../../../../utils/storage.dart';
import '../../../routes/app_pages.dart';

class IntroPageController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  final _globalController = Get.find<GlobalController>();
   int currentIntroIndex =0;
   PageController introController = PageController();
   void nextpage(){
     introController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);

     currentIntroIndex++;
     print("ine index $currentIntroIndex");

     update();
   }
   void changeintroIndex(int index){
     currentIntroIndex = index;
     update();
   }
  void previousPage(){
    introController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);

    currentIntroIndex--;
    print("ine index $currentIntroIndex");

    update();
  }


  Future<void> createNewWalletClickHandler() async {
    Get.toNamed(Routes.generateSeeds, arguments: Get.arguments);

    // if (await pinCodeExists()) {
    //   Get.toNamed(Routes.generateSeeds, arguments: Get.arguments);
    // } else {
    //   Get.toNamed(Routes.lockScreen,
    //       parameters: {'mode': 'create_wallet', 'route': Routes.generateSeeds},
    //       preventDuplicates: true);
    // }
  }

  void restoreWalletClickHandler() {
    pinCodeExists().then((seedStatus) {
      if (seedStatus) {
        Get.toNamed(Routes.restoreWallet, arguments: Get.arguments);
      } else {
        Get.toNamed(Routes.lockScreen,
            parameters: {
              'mode': 'restore_wallet',
              'route': Routes.restoreWallet
            },
            preventDuplicates: true);
      }
    });
  }

  void openLanguageSelector() {
    final supportedLanguages = ["en", "fa"];
    final currentLang = (storageRead(AppKeys.language) ?? "en") as String;
    Get.dialog(LanguageSelectorDialog(
        supportedLanguages, onLanguageSelectHandler, currentLang));
  }

  void onLanguageSelectHandler(String selected) {
    Get.back();
    _globalController.setAppLanguage(selected);
  }
}
