import 'package:akilabanq/presentation/pages/swap/controller/swap_controler.dart';
import 'package:akilabanq/presentation/pages/swap/models/transfare_model.dart';
import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/widgets/app_button.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/widgets/main_pages_appbar.dart';
import 'package:path/path.dart' as path;

class TransfarePage extends StatefulWidget {
  TransfarePage({Key? key, required this.transfare }) : super(key: key);
  final TransfareModel transfare;

  @override
  State<TransfarePage> createState() => _TransfarePageState();
}

class _TransfarePageState extends State<TransfarePage> {
  final SwapController controller = Get.find<
      SwapController>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPagesToolbar(title: widget.transfare.type,),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Center(
                    child: Column(
                      children: [
                        Text(
                          "-${widget.transfare.amount}  ${widget.transfare
                              .tokenSym}",
                          style: AppTextStyles.black_14_w500.copyWith(
                              fontSize: 28),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '\$${widget.transfare.price}',
                          style: AppTextStyles.black_14_w500,
                        )
                      ],
                    ))),
            const SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TransfareText(title: 'Asset',
                            text: '${widget.transfare.tokenName}  (${widget
                                .transfare.tokenSym})'),
                        TransfareText(title: 'From',
                            text: widget.transfare.fromAddress),
                        TransfareText(title: 'To',
                          text: widget.transfare.toAddress,
                          gotBorder: false
                          ,)
                      ],
                    ),
                  ),
                  const Spacer(),

                  Obx(() {
                    return controller.exchnageLoading.value ? Loading() : AppButton.long(text: 'CONFIRM', onTap: () {
                      widget.transfare.callBack();
                    }, child: loading ? Loading() : null,
                    );
                  }),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransfareText extends StatelessWidget {
  const TransfareText(
      {Key? key, required this.title, required this.text, this.gotBorder = true})
      : super(key: key);
  final String title;
  final String text;
  final bool? gotBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: gotBorder!
          ? const Border(bottom: BorderSide(width: 0.5, color: AppColors.lightGrey))
          : const Border()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              child: Text(
                title,
                style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )),
          Flexible(flex: 3, child: TextWithMidEllipsis(text)

            // Text(text.split(path.extension(text))[0] , maxLines: 1, overflow: TextOverflow.ellipsis,)),
          )
        ],
      ),
    );
  }
}

class TextWithMidEllipsis extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign? textAlign;

  const TextWithMidEllipsis(this.data, {
    Key? key,
    this.textAlign,
    this.style = const TextStyle(),
  }) : super(key: key);

  final textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth <= _textSize(data, style).width &&
            data.length > 10) {
          var endPart = data.trim().substring(data.length - 10);
          return Row(
            children: [
              Flexible(
                child: Text(
                  data.fixOverflowEllipsis,
                  style: style,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  textDirection: textDirection,
                ),
              ),
              Text(
                endPart,
                style: style,
                textDirection: textDirection,
                textAlign: textAlign,
              ),
            ],
          );
        }
        return Text(
          data,
          style: style,
          textAlign: textAlign,
          maxLines: 1,
          textDirection: textDirection,
        );
      },
    );
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textDirection: textDirection,
    )
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

extension AppStringExtension on String {
  String get fixOverflowEllipsis =>
      Characters(this)
          .replaceAll(Characters(''), Characters('\u{200B}'))
          .toString();
}
