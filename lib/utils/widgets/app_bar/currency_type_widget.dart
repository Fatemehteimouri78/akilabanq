// import 'package:flutter/material.dart';
//
//
//
// class CurrencyTypeWidget extends StatefulWidget {
//   const CurrencyTypeWidget({Key? key}) : super(key: key);
//
//   @override
//   State<CurrencyTypeWidget> createState() => _CurrencyTypeWidgetState();
// }
//
// class _CurrencyTypeWidgetState extends State<CurrencyTypeWidget> {
//   String currency = "EUR";
//
//   @override
//   Widget build(BuildContext context) {
//     return RectangleNeu(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: currency,
//             style: const TextStyle(color: AppColors.white),
//             iconEnabledColor: AppColors.white,
//             dropdownColor: AppColors.F0F0F3,
//             icon: const Padding(
//               padding: EdgeInsets.only(right: 17),
//               child: const IconWidget(
//                 iconName: IconsClass.simple_arrow_down,
//                 size: 10,
//               ),
//             ),
//             borderRadius: BorderRadius.circular(10),
//             items: [
//               DropdownMenuItem(child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 17),
//                 child: TextWidget(txt: "EUR",style: TypographyClass.t14_500(color: AppColors.black),),
//               ), value: "EUR"),
//               DropdownMenuItem(child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 17),
//                 child: TextWidget(txt: "USD",style: TypographyClass.t14_500(color: AppColors.black),),
//               ), value: "USD"),
//
//             ],
//             onChanged: (value) => setState(() {
//               if (value != null) {
//                 currency = value;
//               }
//             }),
//           ),
//         ));
//   }
// }
