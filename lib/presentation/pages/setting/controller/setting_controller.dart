import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  // final _walletController = Get.find<WalletFragmentController>();
  // final globalController = Get.find<GlobalController>();
//   final _fingerprintValue = false.obs;
//   final _selectedLanguage = "".obs;
//
  @override
  void onInit() {
    print('settingController');
    // getSettings();
    super.onInit();
  }
//
//   String get selectedLanguage => _selectedLanguage.value;
//
//   set selectedLanguage(String value) {
//     _selectedLanguage.value = value;
//   }
//
//   bool get fingerprintValue => _fingerprintValue.value;
//
//   set fingerprintValue(bool value) {
//     _fingerprintValue.value = value;
//   }
//
//   void openSecurityCenter() {
//     // _walletController.prepareReceiveToken();
//     // _walletController.openTokenModal(authenticateForSecurityCenter);
//   }
// }
//
// // void authenticateForSecurityCenter(TokenModel token) {
// //   Get.offNamed(Routes.lockScreen,
// //       parameters: {'route': Routes.securityCenter},
// //       preventDuplicates: true,
// //       arguments: token);
// // }
//
// void fingerprintSwitchHandler(bool value) {
//   // fingerprintValue = value;
//   // storageWrite(AppKeys.fingerprint, value).then((value) => null);
// }
//
// void getSettings() {
//   // if (storageExists(AppKeys.fingerprint)) {
//   //   fingerprintValue = storageRead(AppKeys.fingerprint) as bool;
//   // }
//   //
//   // selectedLanguage = (storageRead(AppKeys.language) ?? "fa") as String;
// }
//
// void modifyPinCode() {
//   Get.toNamed(Routes.lockScreen,
//       parameters: {
//         'mode': 'modify',
//       },
//       preventDuplicates: true);
// }
//
// void openAboutPage() {
//   Get.toNamed(Routes.about);
// }
//
// void openLanguageSelector() {
//   final supportedLanguages = ["en", "fa"];
//
//   // Get.dialog(LanguageSelectorDialog(
//   //     supportedLanguages, onLanguageSelectHandler, selectedLanguage));
// }
//
// void onLanguageSelectHandler(String selected) {
//   Get.back();
//   // globalController.setAppLanguage(selected);
//   getSettings();
// }
//
// void openWalletsPage() {
//   Get.toNamed(Routes.wallet);
// }
//
// String getLanguageLabel(String code) {
//   switch (code) {
//     case 'en':
//       return 'en'.tr;
//     case 'fa':
//       return 'fa'.tr;
//   }
//
//   return "";
}
