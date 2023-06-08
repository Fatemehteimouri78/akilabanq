import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

class LanguageSelectorDialog extends StatelessWidget {
  final List<String> supportedLanguages;
  final Function onClick;
  final String selectedLanguage;

  const LanguageSelectorDialog(
      this.supportedLanguages, this.onClick, this.selectedLanguage);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: Get.height / 3,
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: supportedLanguages.length,
          itemBuilder: (context, index) =>
          selectedLanguage == supportedLanguages[index]
              ? languageSelectedItem(supportedLanguages[index],
                  () => onClick(supportedLanguages[index]))
              : languageItem(supportedLanguages[index],
                  () => onClick(supportedLanguages[index])),
        ),
      ),
    );
  }

  Widget languageItem(String language, GestureTapCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          language.tr,
          style: const TextStyle(color: AppColors.darkGrey),
        ),
      ),
    );
  }

  Widget languageSelectedItem(String language, GestureTapCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(
                  language.tr,
                  style: const TextStyle(color: AppColors.darkGrey),
                )),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
