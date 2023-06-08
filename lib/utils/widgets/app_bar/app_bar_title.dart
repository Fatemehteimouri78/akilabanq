import 'package:akilabanq/temp_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../constant/color.dart';


class TitleAppBar extends StatelessWidget {
  final String title;
  const TitleAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,fit: StackFit.loose,
      children: [
       const CircleNeu(size: 27,),
        const Positioned(left: -1,bottom: 0,child: const CircleGradiant(size: 9)),
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
                color: AppColors.white),
          ),
        ),
      ],
    );
  }
}









