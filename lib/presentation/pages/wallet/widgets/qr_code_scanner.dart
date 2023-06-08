import 'dart:developer';
import 'dart:io';

import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key, required this.callback}) : super(key: key);
  final void Function(String) callback;

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: AppColors.lightGrey,
              borderRadius: 20,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: screenWidth * 0.8),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.close_outlined,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
            top: presentHeight * 20,
            left: 0,
            right: 0,
            // left: screenWidth / 2.5,
            child: Text(
              'Scan Qr Code',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                wordSpacing: 3,
              ),
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  // @override
  // Widget _buildQrView(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: <Widget>[
  //         Expanded(
  //             flex: 1,
  //             child: Text('some texttt')),
  //         Expanded(
  //           flex: 5,
  //           child: QRView(
  //             key: qrKey,
  //             onQRViewCreated: _onQRViewCreated,
  //
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Center(
  //             child: (result != null)
  //                 ? Text(
  //                 'Barcode Type: ')
  //                 : Text('Scan a code'),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        widget.callback(scanData.code!);
        controller.pauseCamera();
        controller.dispose();
        Get.back();
      }
      controller.dispose();

      print("result : ${result?.code}");
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
