import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  animate() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..forward();
    animation = Tween<double>(begin: -4.0, end: 4).animate(CurvedAnimation(parent: animationController, curve: Curves.linear)
      ..addListener(() {
        update();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      }));
  }

  Future<void> Navigate() async {
    final bool userExists = await seedPhraseExists(1);
    final bool passCodeExist = await pinCodeExists();

    await Future.delayed(const Duration(seconds: 3));
    if (userExists && passCodeExist) {
      Get.offAllNamed(Routes.lockScreen);
    } else if (userExists && !passCodeExist) {
      Get.offNamed(Routes.lockScreen, parameters: {'mode': 'create_wallet'});
    } else {
      Get.offNamed(Routes.intro_page);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    animate();
    Navigate();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    animationController.dispose();
    super.onClose();
  }
}
