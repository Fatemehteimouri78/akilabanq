import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final EdgeInsets? margin;
  final String? iconData;
  final double width;
  final bool _isLong;
  final bool isReceive;
  final Color? textColor;
  final double? depth;
  final Widget? child;

  const AppButton({
    required this.text,
    required this.onTap,
    this.isReceive = false,
    this.width = 130,
    this.iconData,
    this.textColor,
    this.depth,
    this.margin,
    this.child,
  }) : _isLong = false;

  const AppButton.long({
    required this.text,
    required this.onTap,
    this.isReceive = false,
    this.width = 130,
    this.iconData,
    this.textColor,
    this.margin,
    this.depth,
    this.child,
  }) : _isLong = true;

  @override
  Widget build(BuildContext context) {
    Widget button;
    if (_isLong) {
      button = Padding(
        padding: const EdgeInsets.all(1.0),
        child: CustomNeumorophic(
          depth: depth ?? 4,
          radius: BorderRadius.circular(50),
          child: SizedBox(
            width: double.infinity - 30,
            child: OutlinedButton(
              onPressed: onTap,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(width, 35)),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey[300];
                  } else {
                    return Colors.transparent;
                  }
                }),
                side: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return BorderSide(color: Colors.grey[300]!);
                  } else {
                    return const BorderSide(color: AppColors.accent);
                  }
                }),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child?? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: iconData != null
                          ? Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(text, style: TextStyle(fontSize: 15, color: textColor ?? AppColors.primary2, fontWeight: FontWeight.w600)),
                                const Gap(10),
                                SvgPicture.asset(
                                  iconData!,
                                  color: textColor,
                                )
                              ],
                            )
                          : Text(text, style: TextStyle(fontSize: 15, color: textColor ?? AppColors.primary2, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      button = CustomNeumorophic(
        lightSource: const LightSource(-1, -1),
        radius: BorderRadius.circular(10),
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, 35)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey[300];
              } else {
                return AppColors.accent;
              }
            }),
            elevation: MaterialStateProperty.all(0),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                SvgPicture.asset(
                  iconData!,
                  width: 20,
                  color: isReceive ? AppColors.deepOrange : AppColors.primary2,
                  fit: BoxFit.cover,
                ),
              const SizedBox(width: 10),
              Text(text, style: TextStyle(fontSize: 14, color: textColor ?? AppColors.primary2, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      );
    }
    if (margin != null) {
      return Container(margin: margin, child: button);
    } else {
      return button;
    }
  }
}
