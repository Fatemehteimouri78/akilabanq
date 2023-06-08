import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/typedef.dart';
import 'package:custom_check_box/custom_check_box.dart';

import 'package:flutter/material.dart';

import '../constant/text_style.dart';

const MaterialColor materialAccentColor = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: AppColors.accent,
    100: AppColors.accent,
    200: AppColors.accent,
    300: AppColors.accent,
    400: AppColors.accent,
    500: AppColors.accent,
    600: AppColors.accent,
    700: AppColors.accent,
    800: AppColors.accent,
    900: AppColors.accent,
  },
);

class AppCheckBox extends StatefulWidget {
  final bool initialValue;
  final String? label;
  final BoolCallback onChange;

  final bool? getTermsText;

  const AppCheckBox({
    required this.onChange,
    this.label,
    this.initialValue = false,
    this.getTermsText = false,
  });

  @override
  State<StatefulWidget> createState() => _State(initialValue);
}

class _State extends State<AppCheckBox> {
  bool isChecked;

  _State(this.isChecked);

  @override
  Widget build(BuildContext context) {
    final checkbox = Theme(
      data: ThemeData(
        unselectedWidgetColor: AppColors.primary,
        primarySwatch: materialAccentColor,
      ),
      child: CustomCheckBox(
        value: isChecked,
        uncheckedIconColor: AppColors.white,
        borderRadius: 5,
        borderWidth: 2.0,
        borderColor: AppColors.orange,
        uncheckedFillColor: AppColors.white,
        checkedFillColor: AppColors.accent,
        checkedIconColor: AppColors.primary2,
        onChanged: (value) {
          setState(() {
            isChecked = value;
            widget.onChange(value);
          });
        },
      ),
    );
    if (widget.label == null) {
      return checkbox;
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
            widget.onChange.call(isChecked);
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkbox,
            Expanded(
                child: RichText(
                    text: TextSpan(children: [
              TextSpan(text: widget.label ?? '', style: AppTextStyles.greylight_14_w500.copyWith(wordSpacing: 0.5, height: 1.5)),
              TextSpan(
                text: widget.getTermsText! ? '\n terms and Services' : '',
                style: const TextStyle(wordSpacing: 0.5, color: Color(0xff0055FF), height: 1.5),
              ),
            ]))),
          ],
        ),
      );
    }
  }
}
