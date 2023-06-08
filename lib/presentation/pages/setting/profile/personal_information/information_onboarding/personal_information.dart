import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/setting/controller/information_onboarding_controller.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PersonalInforfmation extends GetView<InformationOnboardingController> {
  PersonalInforfmation({
    Key? key,
  }) : super(key: key);

  final String _nameErro = "";
  TextEditingController fNameController = TextEditingController();
  TextEditingController refferalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idTypeController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformationOnboardingController>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal information',
                style: AppTextStyles.dark_20_w700,
              ),
              const Gap(10),
              const Text(
                "To ensure security, fill in your personal information",
                style: AppTextStyles.greylight_14_w300,
              ),
              const Gap(30),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomTextField(
                        label: "Refferal Code",
                        hintText: "Enter your refferal code",
                        controller: refferalCodeController,
                        isDigit: true,
                        errorText: _nameErro),
                    GestureDetector(
                      onTap: () {
                        print("p");
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16, color: Colors.black),
                            bottomSheetHeight: 500,
                            // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) =>
                              print('Select country: ${country.displayName}'),
                        );
                      },
                      child: CustomTextField(
                          label: "Country/Region",
                          hintText: "Select country/region",
                          controller: countryController,
                          errorText: _nameErro,
                          clickable: false,
                          hasSuffix: true),
                    ),
                    CustomTextField(
                        label: "First Name",
                        hintText: "Enter first name",
                        controller: fNameController,
                        errorText: _nameErro),
                    CustomTextField(
                        label: "Last Name",
                        hintText: "Enter last name",
                        controller: lNameController,
                        errorText: _nameErro),
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: AppColors.bgColor,
                                height: 200,
                                child: CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1,
                                  useMagnifier: true,
                                  itemExtent: 20,
                                  // This is called when selected item is changed.
                                  onSelectedItemChanged: (int selectedItem) {
                                    print(selectedItem.toString());
                                  },

                                  children: List<Widget>.generate(20, (int index) {
                                    return Center(
                                      child: Text(
                                        "Id Type $index",
                                      ),
                                    );
                                  }),
                                ),
                              );
                            });
                      },
                      child: CustomTextField(
                          label: "ID Type",
                          hintText: "ID Card",
                          controller: idTypeController,
                          hasSuffix: true,
                          errorText: _nameErro,
                          clickable: false,
                          isDigit: true),
                    ),
                    CustomTextField(
                        label: "ID Number",
                        hintText: "Enter ID number",
                        controller: idNumberController,
                        errorText: _nameErro,
                        isDigit: true),
                  ],
                ),
              ),
              AppButton.long(
                text: "Next",
                onTap: () {
                  controller.nextPage();
                },
                iconData: Assets.icons.svg.riArrowRightLine,
              )
            ],
          ),
        );
      }
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required String errorText,
      required this.label,
      required this.hintText,
      this.isDigit = false,
      this.clickable = true,
      this.hasSuffix = false})
      : _errorText = errorText;

  final TextEditingController controller;
  final String _errorText;
  final String label;
  final String hintText;
  final bool isDigit;
  final bool hasSuffix;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.dark_16_w700,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 13.0),
          child: RoundReactNeumorophic(
            padding: 0,
            isCircle: false,
            radius: BorderRadius.circular(10),
            depth: 4,
            child: Align(
              heightFactor: .75,
              child: AbsorbPointer(
                absorbing: !clickable,
                child: FormBuilderTextField(
                  controller: controller,
                  keyboardType:
                      isDigit ? TextInputType.number : TextInputType.text,
                  name: 'email',
                  decoration: InputDecoration(
                    hintText: hintText,
                    errorText: _errorText,
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: hasSuffix
                          ? const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.black,
                              size: 15,
                            )
                          : const SizedBox(),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 13, top: 22, bottom: 1),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onEditingComplete: () {
                    print(controller.value.text);
                  },
                  onSubmitted: (value) {
                    print(value);
                  },
                ),
              ),
            ),
          ),
        ),
        const Gap(20)
      ],
    );
  }
}
