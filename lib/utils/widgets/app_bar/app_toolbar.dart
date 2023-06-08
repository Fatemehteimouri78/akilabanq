import 'package:akilabanq/temp_test.dart';
import 'package:flutter/material.dart';


class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Color? titleColor;
  final Color? backgroundColor;

  AppToolbar({required this.title,
    this.actions = const [],
    this.titleColor = Colors.black87,
    this.backgroundColor});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleGradiant(
                  size: 40,
                  child: Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Icon(
                      Icons.add, size: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Icon(
                  Icons.add, size: 18,
                ),
                const SizedBox(
                  width: 14,
                ),
                TitleAppBar(title: title,),

              ],
            ),
            Row(
              children: [
                ...actions,
                const SizedBox(
                  width: 4,
                ),
                // SizedBox(
                //   height: 35,
                //   width: 36,
                //   child: GestureDetector(
                //     onTap: () => Get.back(),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(color: AppColors.iconLightGrey2)),
                //       child: GetX<GlobalController>(builder: (controller) {
                //         return Center(
                //           child: IconWidget(
                //               iconName: controller.rtl
                //                   ? IconsClass.arrow_left
                //                   : IconsClass.arrow_right,
                //               size: 16,
                //               color: AppColors.iconLightGrey2),
                //         );
                //       }),
                //     ),
                //   ),
                // ),
                // if (actions.isEmpty)
                //   const SizedBox(width: 76)
                // else
                //   const SizedBox(width: 0),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// class IconWidget extends StatelessWidget {
//   final String? iconName;
//   final double size;
//   final Color? color;
//   final VoidCallback? onTap;
//
//   const IconWidget(
//       {Key? key, this.iconName, this.onTap, this.size = 15, this.color})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return iconName == null
//         ? Container()
//         : GestureDetector(
//         onTap: onTap,
//         child: Image.asset(
//           "assets/icons/$iconName.png",
//           height: size,
//           width: size,
//           color: color,
//         ));
//   }
// }