import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/sizes.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

serverDialog(Function callBack) {
  Get.dialog(AlertDialog(
    content: Container(
      height: screenHeight / 3,
      width: screenWidth - 100,
      color: Colors.white,
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'We have a problem please try Again',
          style: AppTextStyles.black_12_w300.copyWith(fontSize: 15),
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('close'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      callBack();
                      Get.back();
                    },
                    child: Text('Try Again'))),
          ],
        )
      ]),
    ),
  ));
}
