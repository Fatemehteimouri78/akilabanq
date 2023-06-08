import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'constant/color.dart';

class CustomNeumorophic extends StatelessWidget {
  const CustomNeumorophic(
      {Key? key,
      required this.radius,
      required this.child,
      this.borderColor,
      this.padding = 0,
      this.opacity,
        this.lightSource,
        this.depth,
        this.borderWidth
      })
      : super(key: key);
  final BorderRadius radius;
  final Widget child;
  final double padding;
  final Color? borderColor;
  final double? opacity;
  final double? depth;
  final LightSource? lightSource;
  final double? borderWidth;


  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        padding: EdgeInsets.all(padding),

        curve: Curves.bounceOut,
        style: NeumorphicStyle(
            color: AppColors.bgColor,
            intensity: .85,
            shadowLightColor: Colors.white,
            boxShape: NeumorphicBoxShape.roundRect(radius),
            shadowDarkColor: Colors.grey.withOpacity(.55),
            depth: depth ?? 4 ,
            shadowDarkColorEmboss: AppColors.darkGrey,
            shadowLightColorEmboss: AppColors.primary2,
            surfaceIntensity: .09,
            lightSource:lightSource?? LightSource.topLeft,
            shape: NeumorphicShape.concave,
            border: NeumorphicBorder(
              color: borderColor??Colors.transparent,
              width: borderWidth??1,
              isEnabled: true,
            )),
        child: child);
  }
}

class RoundReactNeumorophic extends CustomNeumorophic {
  RoundReactNeumorophic(
      {required super.radius,
      required super.child,
      required super.depth,
        super.borderColor,
        super.lightSource,
        super.opacity,
        super.borderWidth,
        super.padding,
      required this.isCircle});

  bool isCircle = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Neumorphic(
        padding: EdgeInsets.all(padding),
        curve: Curves.bounceOut,
        style: NeumorphicStyle(


            boxShape:isCircle?const NeumorphicBoxShape.circle(): NeumorphicBoxShape.roundRect(radius),

            color: AppColors.accent,
            intensity: .85,
            shadowLightColor: Colors.white,
            shadowDarkColor: Colors.grey.withOpacity(.55),

            depth: depth ?? 4,
            surfaceIntensity: .09,
            lightSource:lightSource?? LightSource.topLeft,
            shape: NeumorphicShape.concave,
            border: NeumorphicBorder(
              color:borderColor?? Colors.transparent,
              width: borderWidth??1,
              isEnabled: true,
            )),
        child: child);
  }
}
