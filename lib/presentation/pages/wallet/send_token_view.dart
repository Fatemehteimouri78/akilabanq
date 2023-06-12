import 'dart:convert';

import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/home/controller/home_controller.dart';
import 'package:akilabanq/presentation/pages/swap/models/transfare_model.dart';
import 'package:akilabanq/presentation/pages/swap/transfare_page.dart';
import 'package:akilabanq/presentation/pages/wallet/wallet_transfer_page.dart';
import 'package:akilabanq/presentation/pages/wallet/widgets/qr_code_scanner.dart';
import 'package:akilabanq/utils/constant/sizes.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/widgets/cached_image.dart';
import '../../../utils/widgets/decimal_input_formatter.dart';
import 'controller/token_transactions_controller.dart';
import 'model/token_model.dart';

import 'package:flutter/services.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';

class SendTokenview extends StatefulWidget {
  SendTokenview({Key? key}) : super(key: key);

  @override
  State<SendTokenview> createState() => _SendTokenviewState();
}

class _SendTokenviewState extends State<SendTokenview> {
  late TokenModel token;
  late final TokenTransactionController controller ;

  final _sendTokenKey = GlobalKey<FormBuilderState>();
  final amountController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
   controller = Get.put(TokenTransactionController());
    token = controller.currentToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<HomeController>().changePageIndex(5);
        return false;
      },
      child: Scaffold(
        appBar: MainPagesToolbar(
          title: 'Send ${token.name}',
          gotLeading: true,
          leadingCallBack: () => Get.find<HomeController>().changePageIndex(5),
        ),
        body: Container(
          margin: mainPagesPadding,
          height: screenHeight,
          child: FormBuilder(
            key: _sendTokenKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 64,
                  child: RoundReactNeumorophic(
                    depth: 7,
                    isCircle: false,
                    lightSource: const LightSource(-1, -2),
                    radius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 39,
                            width: 39,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(0),
                            child: cachedImage(token.icon, boxFit: BoxFit.fill),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Available balance',
                                style: AppTextStyles.greylight_12_w300,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                token.name,
                                style: AppTextStyles.black_14_w500,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                token.balance.toString(),
                                style: AppTextStyles.greylight_12_w300,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                token.tokenValue.toString(),
                                style: AppTextStyles.green_12_w400,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const Text(
                      'To',
                      style: AppTextStyles.black_14_w500,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () =>
                          Get.to(QRViewExample(
                            callback: (String code) {
                              final Map<String, dynamic> barcodeResult =
                              json.decode(code);

                              setState(() {
                                addressController.text = barcodeResult['token'];
                                if (barcodeResult['amount'] != null ||
                                    barcodeResult['amount'] != '') {
                                  amountController.text = barcodeResult['amount'];
                                }
                              });
                            },
                          )),
                      child: SvgPicture.asset(
                        Assets.icons.svg.iconoirScanQrCode,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const InkWell(
                      child: Icon(Icons.person_add_alt_1_outlined, size: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        ClipboardData? cdata =
                        await Clipboard.getData(Clipboard.kTextPlain);
                        setState(() {
                          addressController.text = cdata!.text!;
                        });
                      },
                      child: const Icon(
                        Icons.save_outlined,
                        size: 20,
                        color: Color(0xFFFE983F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 85,
                  width: double.infinity,
                  child: RoundReactNeumorophic(
                    isCircle: false,
                    lightSource: const LightSource(-1, -2),
                    radius: BorderRadius.circular(10),
                    depth: 7,
                    child: FormBuilderTextField(
                      name: 'address',
                      textAlign: TextAlign.start,
                      controller: addressController,
                      maxLines: 2,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      scrollPhysics: const ScrollPhysics(),
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                          hintText: 'please enter address or use abow items',
                          hintStyle: AppTextStyles.greylight_12_w300
                              .copyWith(letterSpacing: 0.5),
                          contentPadding:
                          const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 10.0),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Amount:",
                      style: AppTextStyles.black_14_w500,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        ClipboardData? cdata =
                        await Clipboard.getData(Clipboard.kTextPlain);
                        setState(() {
                          amountController.text = cdata!.text!;
                        });
                      },
                      child: const Icon(
                        Icons.save_outlined,
                        size: 20,
                        color: Color(0xFFFE983F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 52,
                  width: double.infinity,
                  child: RoundReactNeumorophic(
                    isCircle: false,
                    lightSource: const LightSource(-1, -2),
                    radius: BorderRadius.circular(10),
                    depth: 7,
                    child: FormBuilderTextField(
                      name: 'amount',
                      // textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      controller: amountController,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                        DecimalTextInputFormatter(decimalRange: token.decimals)
                      ],
                      decoration: InputDecoration(
                          hintText: 'please enter amount',
                          hintStyle: AppTextStyles.greylight_12_w300
                              .copyWith(letterSpacing: 0.5),
                          contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 17.0),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const Spacer(),

                  AppButton.long(
                    text: 'Next',

                    onTap: () async {
                      Get.find<HomeController>().changePageIndex(5);

                      _sendTokenKey.currentState?.save();
                      if (_sendTokenKey.currentState!.isValid) {
                        double amount = double.tryParse(_sendTokenKey.currentState!.value['amount'])??0.0;
                        await controller.estimateFee(address: token.address, amount: amount);
                        if(amount +  controller.estimatedFee.value <= (token.balance??0)){

                      Get.to( WalletTransfarePage( transfare: TransfareModel(type: 'Transfer',
                      tokenName: token.name,
                      tokenSym: token.symbol,
                      amount: amount,
                      price: token.price??0.0,
                      fromAddress: token.address,
                      toAddress: addressController.text,
                      callBack: ()async {
                        final bool transfar = await controller.trasnfarToken(addressController.text, amountController.text);
                      if(transfar){
                      showSuccessToast('Transfer was successful');
                      Get.back();
                      Get.find<HomeController>().changePageIndex(5);

                      } else {
                      showWarningToast('We have an Error During Transfer');
                      }

                      } ),));
                      }else{
                      showWarningToast('Insufficient balance to transfer');
                      }
                      } else {
                        showInfoToast('Please Enter your Address and Amount');
                      }
                    },

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SendTokenHeader extends StatefulWidget {
  const SendTokenHeader({Key? key, required this.title, required this.callBack})
      : super(key: key);
  final String title;
  final void Function(String) callBack;

  @override
  State<SendTokenHeader> createState() => _SendTokenHeaderState();
}

class _SendTokenHeaderState extends State<SendTokenHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: AppTextStyles.black_14_w500,
        ),
        const Spacer(),
        InkWell(
          onTap: () =>
              Get.to(QRViewExample(
                callback: (String code) {
                  setState(() {});
                },
              )),
          child: SvgPicture.asset(
            Assets.icons.svg.iconoirScanQrCode,
            height: 20,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const InkWell(
          child: Icon(Icons.person_add_alt_1_outlined, size: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        const InkWell(
          child: Icon(
            Icons.save_outlined,
            size: 20,
            color: Color(0xFFFE983F),
          ),
        ),
      ],
    );
  }
}
