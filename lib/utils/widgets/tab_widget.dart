import 'package:akilabanq/utils/constant/color.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class TabWidget extends StatelessWidget {
  bool isSelected;
  Widget? child;
  VoidCallback? onTap;
  double? height,width;
  EdgeInsetsGeometry? padding,margin;
  TabWidget({Key? key,this.isSelected = false,this.child,this.onTap,this.height,this.padding,this.margin,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin??EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Neumorphic(
          style: NeumorphicStyle(
            color: AppColors.F0F0F3,
              depth: isSelected ? -3 : 3,
              intensity: .9,
              lightSource:const LightSource(-1, -1),
              shadowLightColorEmboss: Colors.white,surfaceIntensity: 20,
              shadowDarkColorEmboss: AppColors.grey3.withOpacity(.5),
              border: NeumorphicBorder(
                color: Colors.grey.withOpacity(.01),
              )),
          child: Column(
            children: [
              Container(
                height: height,
                width: width,
                padding: padding,
                alignment: Alignment.center,
                child: FittedBox(child: child),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
