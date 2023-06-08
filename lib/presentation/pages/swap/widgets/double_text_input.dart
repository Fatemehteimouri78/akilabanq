import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../utils/constant/text_style.dart';
class DoubleTextInput extends StatelessWidget {
  const DoubleTextInput({Key? key , required this.callback , this.hintText}) : super(key: key);
 final Function(String value) callback;
 final String? hintText;
  @override
  Widget build(BuildContext context) {
    return  FormBuilderTextField(
      name: 'amount',
      // textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,

      onChanged: (value){
        callback;
      },
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      keyboardType:
      const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
      ],
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.greylight_12_w300
              .copyWith(letterSpacing: 0.5),
          // contentPadding:
          // const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 17.0),
          border: InputBorder.none
      ),
    );
  }
}
