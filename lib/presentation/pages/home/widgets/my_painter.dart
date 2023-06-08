import 'package:flutter/cupertino.dart';

import '../../../../utils/constant/color.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9279070, size.height * 0.3464052);
    path_0.cubicTo(size.width * 0.9677233, size.height * 0.3464052, size.width,
        size.height * 0.4371190, size.width, size.height * 0.5490196);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.5490196);
    path_0.cubicTo(
        0,
        size.height * 0.4371190,
        size.width * 0.03227721,
        size.height * 0.3464052,
        size.width * 0.07209302,
        size.height * 0.3464052);
    path_0.lineTo(size.width * 0.3273372, size.height * 0.3464052);
    path_0.cubicTo(
        size.width * 0.3420907,
        size.height * 0.3464052,
        size.width * 0.3564884,
        size.height * 0.3336843,
        size.width * 0.3685860,
        size.height * 0.3099601);
    path_0.lineTo(size.width * 0.4223860, size.height * 0.2044706);
    path_0.cubicTo(
        size.width * 0.4691116,
        size.height * 0.1128542,
        size.width * 0.5311186,
        size.height * 0.1119176,
        size.width * 0.5781907,
        size.height * 0.2021176);
    path_0.lineTo(size.width * 0.6351140, size.height * 0.3111961);
    path_0.cubicTo(
        size.width * 0.6470860,
        size.height * 0.3341359,
        size.width * 0.6612372,
        size.height * 0.3464052,
        size.width * 0.6757279,
        size.height * 0.3464052);
    path_0.lineTo(size.width * 0.9279070, size.height * 0.3464052);
    path_0.close();

    Paint paint0Fill = Paint()
      ..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.accent.withOpacity(1);
    canvas.drawShadow(
      path_0,
      AppColors.black,
      10,
      false,
    );

    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}