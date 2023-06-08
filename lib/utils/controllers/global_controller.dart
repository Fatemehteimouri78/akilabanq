import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../presentation/routes/app_pages.dart';
import '../constant/app_keys.dart';
import '../secure_storage.dart';
import '../storage.dart';
import '../theme.dart';

class GlobalController extends FullLifeCycleController with FullLifeCycleMixin {
  final secureStorage = const FlutterSecureStorage();

  bool appLocked = false;

  bool appClosed = false;


  final _appTheme = (AppThemes.lightTheme).obs;

  @override
  void onInit() async {
    selectedLang = (storageRead(AppKeys.language) ?? "en") as String;
    appTheme = getAppTheme(selectedLang);
    // defineAppDirection(selectedLang);

    super.onInit();
  }

  ThemeData get appTheme => _appTheme.value;

  set appTheme(ThemeData value) {
    _appTheme.value = value;
  }

  final _rtl = false.obs;

  String selectedLang = "";

  bool get rtl => _rtl.value;

  set rtl(bool value) {
    _rtl.value = value;
  }


  // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  // print('resultt ::::::: $result');
  // if (result == ConnectivityResult.none) {
  // isOffline.value = true;
  // getCoins();
  // } else if (result == ConnectivityResult.mobile ||
  // result == ConnectivityResult.wifi ||
  // result == ConnectivityResult.vpn) {
  // isOffline.value = false;
  // getCoins();
  // }
  // });

  Future<void> setAppLanguage(String code) async {
    Get.updateLocale(Locale(code, getCountryCode(code)));
    // defineAppDirection(code);
    appTheme = getAppTheme(code);
    await storageWrite(AppKeys.language, code);
    selectedLang = code;
  }

  ThemeData getAppTheme(String code) {
    print(code);
    switch (code) {
      case "fa":
        return AppThemes.lightTheme;
      case "en":
        return AppThemes.lightTheme;
    }

    return AppThemes.lightTheme;
  }

  Locale getAppLanguage() {
    if (storageExists(AppKeys.language)) {
      return Locale(selectedLang, getCountryCode(selectedLang));
    }
    return const Locale("fa", "IR");
  }

  String getCountryCode(String code) {
    String countryCode = "";

    switch (code) {
      case "fa":
        countryCode = 'IR';
        break;
      case "en":
        countryCode = 'US';
        break;
    }

    return countryCode;
  }

  // void defineAppDirection(String code) {
  //   bool rtl = false;
  //   switch (code) {
  //     case "fa":
  //       rtl = true;
  //       break;
  //   }

  //   rtl = rtl;
  // }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  Future<void> onPaused() async {
    bool pinCodeExist = await pinCodeExists();
    appClosed = true;
    if (appClosed && pinCodeExist) {
      Timer(const Duration(minutes: 1), () {
        Get.toNamed(Routes.lockScreen,
            parameters: {'mode': 'app_lock'}, preventDuplicates: true);
      });
    }
  }

  @override
  void onResumed() {
    appClosed = false;
  }

  // dynamic findSettings(String settingKey) {
  //   for (final setting in appSettings) {
  //     if (setting.setting == settingKey) {
  //       return setting.value;
  //     }
  //   }
  // }

  void initializeApiClient(String apiVersion) {
    // Get.put(ApiClient(apiVersion: apiVersion), permanent: true);
  }
}
