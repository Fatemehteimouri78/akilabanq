import 'package:akilabanq/presentation/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:akilabanq/utils/constant/text_style.dart';
import 'package:akilabanq/utils/cutom_neumero.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../constant/color.dart';

class IntroPagesToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  IntroPagesToolbar({super.key, required this.title, this.actions = const []});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: CustomNeumorophic(
            radius: BorderRadius.circular(8),
            depth: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  const Icon(Icons.arrow_back_outlined),
                  Expanded(
                      child: Text(
                    title,
                    style: AppTextStyles.dark_18_w700,
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            )),
      ),
    );
  }
}

class MainPagesToolbar extends StatelessWidget implements PreferredSizeWidget {
  const MainPagesToolbar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.gotLeading = false,
    this.leadingCallBack,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final bool gotLeading ;
  final Callback? leadingCallBack;

    @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Stack(
          alignment: Alignment.bottomLeft,
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [

            Row(
              children: [
              gotLeading ?  Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: leadingCallBack,
                    child: Icon(Icons.arrow_back)),
                ) : SizedBox(),

                RoundReactNeumorophic(
                  isCircle: true,
                  radius: BorderRadius.zero,
                  depth: 4,
                  lightSource: const LightSource(1, -1),
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.accent,
                  ),
                ),
              ],
            ),
             Positioned(
              left: gotLeading ? 43 : 3 ,
              bottom: 1,
              child: const CircleAvatar(
                radius: 5,
                backgroundColor: AppColors.deepOrange,
              ),
            ),
            Positioned(
                left: gotLeading ?  57 : 17,
                child: Text(
                  title,
                  style: AppTextStyles.dark_18_w700,
                )),
            Positioned(
              right: 10,
              child: Row(
                children: actions.map((e) => Padding(padding: const EdgeInsets.only(left: 10), child: e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
