import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import 'constant/color.dart';

bool messagePermitted = true;

String transactionLinkGenerator(String link) {
  return 'https://talanexplorer.com/tx/$link';
}

void makeCustomToast(String message,
    {Toast length = Toast.LENGTH_SHORT,
      Color bgColor = Colors.white,
      Color textColor = Colors.black,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
  if (messagePermitted) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: gravity,
        timeInSecForIosWeb: 3,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
    messagePermitted = false;
    Future.delayed(const Duration(seconds: 5)).then((value) {
      messagePermitted = true;
    });
  }
}

void showCustomSnackBar(String text) {
  if (messagePermitted) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.black,
        margin: EdgeInsets.only(
            bottom: Get.height * 0.075,
            left: Get.width * 0.0453,
            right: Get.width * 0.0453),
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.01, horizontal: Get.width * 0.0426),
        content: Row(
          children: [
            const Icon(
              Icons.info,
              color: AppColors.white,
            ),
            SizedBox(
              width: Get.width * 0.032,
            ),
            Flexible(child: Text(text)),
          ],
        )));
    messagePermitted = false;
    Future.delayed(const Duration(seconds: 5)).then((value) {
      messagePermitted = true;
    });
  }
}

void vibrate() {
  Vibration.hasVibrator().then((value) => value! ? Vibration.vibrate() : null);
}

void vibrateWithDuration(int duration) {
  Vibration.hasCustomVibrationsSupport()
      .then((value) => value! ? Vibration.vibrate(duration: duration) : null);
}

void vibrateWithAmplitude(int amplitude) {
  Vibration.hasAmplitudeControl()
      .then((value) => value! ? Vibration.vibrate(amplitude: amplitude) : null);
}

String fixTimeAndDateFormat(int digit) {
  if (digit.toString().length == 1) {
    return '0$digit';
  }
  return digit.toString();
}
