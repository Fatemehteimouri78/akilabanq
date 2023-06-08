import 'package:akilabanq/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLinkText extends StatefulWidget {
  final String text;
  final String link;
  final bool showCircle;
  final double fontSize;

  const AppLinkText(
      {required this.text,
        required this.link,
        this.showCircle = false,
        this.fontSize = 12});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AppLinkText> {
  Color textColor = AppColors.darkGrey;
  bool clicked = false;
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (details) {
        setState(() {
          textColor = Colors.purple;
        });
      },
      onPanEnd: (details) {
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() {
            textColor = AppColors.accent;
          });
        });
      },
      onPanCancel: () {
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() {
            if (!clicked) textColor = AppColors.accent;
          });
        });
      },
      onTap: () {
        setState(() {
          textColor = Colors.purple;
          clicked = true;
        });
        _launchUrl(widget.link);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showCircle) ...[
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    color: textColor, borderRadius: BorderRadius.circular(30)),
              ),
              const SizedBox(width: 4),
            ],
            Expanded(
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(color: textColor, fontSize: widget.fontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
