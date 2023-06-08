import 'package:akilabanq/utils/utils_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

import '../../../../utils/constant/text_style.dart';

class CointText extends StatelessWidget {
  const CointText(
      {Key? key,
      required this.textOne,
      required this.textTwo,
      required this.textThree,
      this.isRich = false})
      : super(key: key);
  final String textOne;
  final String textTwo;
  final String textThree;
  final bool isRich;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isRich ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        textOne == 'null'
            ? const SpinKitThreeBounce(
                color: Colors.grey,
                size: 25.0,
              )
            : RichText(
                textDirection: TextDirection.ltr,
                text: TextSpan(
                    text: textOne,
                    style: AppTextStyles.dark_14_w700,
                    children: <TextSpan>[
                      TextSpan(
                        text: " $textTwo",
                        style: isRich
                            ? AppTextStyles.dark_12_w300
                            : AppTextStyles.dark_14_w700,
                      )
                    ])),
        const Gap(8),
        textThree == 'null' || textThree.isEmpty
            ? const SpinKitThreeBounce(
                color: Colors.grey,
                size: 15.0,
              )
            : Text(
                textThree,
                style: AppTextStyles.greylight_12_w300,
              )
      ],
    );
  }
}
