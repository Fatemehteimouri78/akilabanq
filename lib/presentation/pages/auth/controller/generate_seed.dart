import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mnemonic/mnemonic.dart';

import '../repositoy/seed_repo.dart';

class GenerateSeedsPageController extends GetxController {
  final _seeds = <String>[].obs;
  bool understand = false;
  bool agreed = false;

  @override
  void onInit() {
    generateSeedWords();
    super.onInit();
  }

  void generateSeedWords() async {

    seeds = await SeedRepository.generateSeed();
  }

  List<String> get seeds => _seeds.value;

  set seeds(List<String> value) {
    _seeds.value = value;
  }

  bool checkForSeedRepetition(String mnemonic) {
    final seeds = mnemonic.split(' ');

    final seedsSet = <String>{};

    for (final seed in seeds) {
      seedsSet.add(seed);
    }

    return seedsSet.length == 12;
  }

  void verifyForm() {
    if (understand == false || agreed == false) {
      makeCustomToast('agree_to_terms_of_service'.tr, length: Toast.LENGTH_LONG, bgColor: Colors.redAccent, textColor: Colors.white);
    } else {
      Get.toNamed(Routes.verifySeeds, parameters: {'seeds': seeds.join(' ')}, arguments: Get.arguments);
    }
  }

  void agreeCheckBoxChangeHandler(bool value) {
    agreed = value;
    update();
  }

  void understandCheckBoxChangeHandler(bool value) {
    understand = value;
    update();
  }
}
