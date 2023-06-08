import 'package:akilabanq/services/localization/en_US.dart';
import 'package:get/get.dart';


import 'package:flutter/material.dart';



class TranslationService extends Translations {
  // static Locale? get locale => Get.deviceLocale;
    static Locale? get locale => Locale('en', 'Us');
  static const fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,

  };
}


