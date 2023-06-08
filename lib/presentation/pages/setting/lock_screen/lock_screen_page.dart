import 'package:akilabanq/presentation/pages/setting/lock_screen/lock_screen_controller.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LockScreenPage extends GetView<LockScreenPageController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPressedHandler,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => Opacity(opacity: controller.appBarVisibility ? 1 : 0, child: IntroPagesToolbar(title: controller.appBarText))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Obx(() => Text(controller.pageTitle, style: AppTextStyles.black_14_w500, textAlign: TextAlign.center)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: PinCodeTextField(
                                appContext: context,
                                autoDisposeControllers: false,
                                controller: controller.pinCodeController,
                                textStyle: const TextStyle(
                                  color: AppColors.darkGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                                cursorColor: Colors.transparent,
                                enablePinAutofill: false,
                                focusNode: controller.pinFocus,
                                autoDismissKeyboard: false,
                                length: 6,
                                obscureText: true,
                                animationType: AnimationType.fade,
                                autovalidateMode: AutovalidateMode.disabled,
                                obscuringCharacter: '*',
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(6),
                                    fieldHeight: Get.width * 0.13,
                                    fieldWidth: Get.width * 0.13,
                                    errorBorderColor: Colors.transparent,
                                    inactiveFillColor: Colors.white70.withOpacity(0.2),
                                    selectedColor: AppColors.primary2.withOpacity(.4),
                                    selectedFillColor: Colors.white.withOpacity(0.1),
                                    activeFillColor: Colors.white.withOpacity(0.1),
                                    disabledColor: Colors.white.withOpacity(0.2),
                                    inactiveColor: Colors.transparent,
                                    activeColor: Colors.transparent),
                                animationDuration: const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                onChanged: (value) => {},
                                onCompleted: controller.pinOnCompleteHandler,
                                errorAnimationController: controller.errorController,
                              ),
                            ),
                          ),
                          Text(
                            'The password is 6 digit 0-9 Arabic numerals\n You can type every thing here.'.tr,
                            style: AppTextStyles.greylight_14,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                      AppButton.long(
                        text: 'ok'.tr,
                        onTap: controller.onOkBtnClickHandler,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
