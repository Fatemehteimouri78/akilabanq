import 'package:akilabanq/utils/constant/color.dart';
import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:akilabanq/utils/widgets/app_bar/app_toolbar.dart';
import 'package:akilabanq/utils/widgets/main_pages_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TempTest extends StatelessWidget {
  const TempTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:           MainPagesToolbar(title: "salam")
      ,
      body: Column(
        children: [
        ],
      ),
    );
  }
}

class TitleAppBar extends StatelessWidget {
  final String title;

  const TitleAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.loose,
      children: [
        const CircleNeu(
          size: 27,
        ),
        Positioned(left: -1, bottom: 0, child: CircleGradiant(size: 9)),
        Positioned(
          left: 16,
          top: 3,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.red),
          ),
        ),
      ],
    );
  }
}

class CircleNeu extends StatelessWidget {
  final double size;
  final Widget? child;
  final bool deep;

  const CircleNeu({Key? key, required this.size, this.child, this.deep = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          color: AppColors.white,
          depth: deep ? -7 : 3,
          lightSource: const LightSource(-1.1, -1.1),
          shadowLightColorEmboss: Colors.white.withAlpha(-1),
          shadowDarkColorEmboss: AppColors.white,
          boxShape: NeumorphicBoxShape.circle(),
          border: NeumorphicBorder(
            color: Colors.grey.withOpacity(.01),
          )),
      child: Container(height: size, width: size, child: child),
    );
  }
}

class CircleGradiant extends StatelessWidget {
  final double size;
  final Widget? child;

  const CircleGradiant({Key? key, required this.size, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: AppColors.red,
          shape: BoxShape.circle,
          gradient: LinearGradient(
              tileMode: TileMode.decal,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.orange.withOpacity(0.7), AppColors.orange]),
          boxShadow: [
            BoxShadow(
              color: AppColors.red.withOpacity(0.7),
              offset: const Offset(5.13, 5.13),
              blurRadius: 15.4,
            ),
            BoxShadow(
              color: AppColors.white,
              offset: Offset(-5.13, -5.13),
              blurRadius: 15.4,
            ),
          ]),
      child: child ?? Container(),
    );
  }
}
