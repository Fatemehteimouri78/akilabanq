import 'dart:convert';

import 'package:akilabanq/presentation/pages/home/controller/home_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/controller/token_transactions_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/wallet_view.dart';
import 'package:akilabanq/utils/constant/sizes.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/utils_function.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class RecieveTokenView extends StatefulWidget {
  @override
  State<RecieveTokenView> createState() => _RecieveTokenViewState();
}

class _RecieveTokenViewState extends State<RecieveTokenView> {
  final TokenModel token = Get.find<TokenTransactionController>().currentToken;
  late var qrData;

  @override
  void initState() {
    Get.put(TokenTransactionController());
    setQrData('');
    super.initState();
  }

  setQrData(String amount) {
    final myData = {'token': token.address, 'amount': amount};
    setState(() {
      qrData = jsonEncode(myData);
    });
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
            title: 'Recieve ${token.name}',
            gotLeading: true,
            leadingCallBack: () =>
                Get.find<HomeController>().changePageIndex(5),
          ),
          body: Container(
            margin: mainPagesPadding,
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Amount:',
                  style: AppTextStyles.black_14_w500,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 52,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: RoundReactNeumorophic(
                    depth: 7,
                    isCircle: false,
                    lightSource: const LightSource(-1, -2),
                    radius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        onChanged: (value) => setQrData(value),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'please enter amount',
                            hintStyle: AppTextStyles.greylight_12_w300),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenWidth * 0.6,
                    child: RoundReactNeumorophic(
                      depth: 7,
                      isCircle: false,
                      lightSource: const LightSource(-1, -2),
                      radius: BorderRadius.circular(10),
                      child: QrImageView(
                        data: qrData,
                        padding: const EdgeInsets.all(26),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Text(
                  token.address,
                  style: AppTextStyles.black_14_w500,
                ),
                // SizedBox(height: screenHeight * 0.1,),
                Spacer(),
                AppButton.long(
                    text: 'Copy Address',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: token.address));
                      showSuccessToast('address copied to Clipboard');
                    }),
              ],
            ),
          )),
    );
  }
}
