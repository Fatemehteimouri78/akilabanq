import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/controllers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utils/constant/app_keys.dart';
import '../../../../utils/finger_print.dart';
import '../../../../utils/secure_storage.dart';
import '../../../../utils/storage.dart';
import '../../../../utils/utility.dart';

class LockScreenPageController extends GetxController {
  final GlobalController _globalController = Get.find();
  final secureStorage = const FlutterSecureStorage();
  final pinCodeController = TextEditingController();
  final errorController = StreamController<ErrorAnimationType>.broadcast();
  final pinFocus = FocusNode();

  bool typingAllowed = true;
  bool deletingAllowed = false;

  String enteredPinCode = "";
  String stage = 'one';
  String route = Routes.home;
  String mode = 'lock';

  final _appBarVisibility = false.obs;
  final _appBarText = ('create_new_wallet'.tr).obs;
  final _pageTitle = ('Please Enter Your Password'.tr).obs;

  @override
  void onInit() {
    _globalController.appLocked = true;
    defineMode();
    super.onInit();
  }

  @override
  void onReady() {
    defineAuthType();
    super.onReady();
  }

  String get pageTitle => _pageTitle.value;

  set pageTitle(String value) {
    _pageTitle.value = value;
  }

  String get appBarText => _appBarText.value;

  set appBarText(String value) {
    _appBarText.value = value;
  }

  bool get appBarVisibility => _appBarVisibility.value;

  set appBarVisibility(bool value) {
    _appBarVisibility.value = value;
  }

  void defineMode() {
    final params = Get.parameters;
    if (params.containsKey('mode')) {
      mode = params['mode']!;
    }

    if (params.containsKey('route')) {
      route = params['route']!;
    }

    if (mode == 'create_wallet') {
      appBarVisibility = true;
      appBarText = 'Passcode Creation'.tr;
    } else if (mode == 'restore_wallet') {
      appBarVisibility = true;
      appBarText = 'Restore Wallet'.tr;
    } else if (mode == 'modify') {
      pageTitle = 'enter_your_current_pin_code'.tr;
      stage = 'three';
    } else {
      appBarVisibility = false;
    }
  }

  void editPassword() {
    switch (stage) {
      case 'one':
        stageOne();
        break;
      case 'two':
        if (pinCodeController.text == enteredPinCode) {
          pinFocus.unfocus();
          vibrateWithDuration(50);
          savePinCode(enteredPinCode).then((value) {
            if (mode == 'modify') {
              Get.back();
            } else {
              Get.offNamed(route);
            }
          });
        } else {
          passwordError();
          stage = 'one';
          pageTitle = 'Enter Your Current Pin Code'.tr;
          makeCustomToast('Pin Codes Dnot Match'.tr);
        }
        break;
      case 'three':
        loadPinCode().then((currentPassword) {
          if (currentPassword == pinCodeController.text) {
            stage = 'one';
            pageTitle = 'enter_new_pin_code'.tr;
            pinCodeController.clear();
          } else {
            passwordError();
          }
        });
        break;
    }
  }

  void pinOnCompleteHandler(String value) {
    print('modeeeee : $mode');
    if (mode == 'lock' || mode == 'middleware' || mode == 'app_lock') {
      enteredPinCode = value;
      unlockApp();
    } else if (mode == 'modify') {
      editPassword();
    } else {
      setNewPassword(value);
    }
  }

  void onOkBtnClickHandler() {
    makeCustomToast('Enter Pin Code to Unlock App'.tr, length: Toast.LENGTH_LONG, bgColor: Colors.redAccent, textColor: Colors.white);
  }

  void unlockApp() {
    loadPinCode().then((pinCode) {
      if (pinCode == enteredPinCode) {
        vibrateWithDuration(100);
        leavePage();
      } else {
        vibrateWithDuration(300);
        pinCodeController.clear();
        pageTitle = 'Incorrect Pin Code'.tr;
        errorController.add(ErrorAnimationType.shake);
        makeCustomToast('Incorrect Pin Code'.tr, length: Toast.LENGTH_LONG, bgColor: Colors.redAccent, textColor: Colors.white);
      }
    });
  }

  void setNewPassword(String value) {
    if (stage == 'one') {
      stageOne();
    } else {
      if (pinCodeController.text == enteredPinCode) {
        pinFocus.unfocus();
        vibrateWithDuration(50);
        savePinCode(enteredPinCode).then((value) => leavePage());
      } else {
        stage = 'one';
        pageTitle = 'Enter Pin Code'.tr;

        makeCustomToast('Pin Codes Dnot Match'.tr, length: Toast.LENGTH_LONG, bgColor: Colors.redAccent, textColor: Colors.white);
      }
    }
  }

  void stageOne() {
    enteredPinCode = pinCodeController.text;
    pinCodeController.clear();
    stage = 'two';
    pageTitle = 'Please Enter Passcode Again'.tr;
  }

  void passwordError() {
    errorController.add(ErrorAnimationType.shake);
    vibrateWithDuration(300);
    pinCodeController.clear();
  }

  void leavePage() {
    if (mode == 'middleware' || mode == 'app_lock') {
      Get.back(result: true);
    } else if (mode == 'create_wallet') {
      Get.offAllNamed(Routes.created_wallet);
    } else {
      if (route == Routes.securityCenter) {
        Get.offNamed(route, arguments: Get.arguments);
      } else {
        Get.offNamed(route);
      }
    }

    _globalController.appLocked = false;
  }

  void defineAuthType() {
    if (mode != 'define' && mode != 'modify' && storageExists(AppKeys.fingerprint)) {
      print("hi1");
      if (storageRead(AppKeys.fingerprint) as bool) {
        print("hi0");
        checkFingerPrintSupport();
      }
    } else {
      pinFocus.requestFocus();
    }
  }

  Future<void> checkFingerPrintSupport() async {
    if (await FingerPrint.supportsBiometrics() && await FingerPrint.supportsFingerPrint()) {
      print("hi2");
      final auth = await FingerPrint.authenticate();
      print("hi3");
      if (auth) {
        if (mode == 'modify') {
          stage = 'one';
        } else {
          leavePage();
        }
      } else {
        makeCustomToast('auth_failed'.tr);
      }
    }
  }

  Future<bool> onBackPressedHandler() {
    if (mode == 'app_lock') {
      SystemNavigator.pop();
      return Future.value(false);
    }
    _globalController.appLocked = false;
    return Future.value(true);
  }

  @override
  void onClose() {
    _globalController.appLocked = false;
    errorController.close();
    super.onClose();
  }
}
