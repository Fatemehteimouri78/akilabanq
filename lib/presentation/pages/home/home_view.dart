import 'package:akilabanq/gen/assets.gen.dart';
import 'package:akilabanq/presentation/pages/category/category_view.dart';
import 'package:akilabanq/presentation/pages/home/controller/home_controller.dart';
import 'package:akilabanq/presentation/pages/home/widgets/my_painter.dart';
import 'package:akilabanq/presentation/pages/home/widgets/wallet_tab.dart';
import 'package:akilabanq/presentation/pages/swap/swap_view.dart';
import 'package:akilabanq/presentation/pages/trade/trade_view.dart';
import 'package:akilabanq/presentation/pages/wallet/token_transactions.dart';

import 'package:akilabanq/presentation/pages/wallet/wallet_view.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../setting/setting_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {

          return Scaffold(
              body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controller.pageController,
                itemBuilder: (context, index) =>
                    controller.pages[controller.pageIndex].page,
                itemCount: controller.pages.length,
              ),
              CustomPaint(
                  size: Size(
                      Get.width, (Get.width * 0.3558139534883721).toDouble()),
                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically

                  painter: MyPainter(),
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    width: Get.width,
                    height: 140,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          5,
                          (index) => index == 2
                              ? GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.changePageIndex(index);
                                    controller.startanimate(index);
                                  },
                                  child: ShakeAnimatedWidget(
                                      enabled: controller.animate[2],
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      shakeAngle: Rotation.deg(z: 40),
                                      curve: Curves.linear,
                                      child: WalletTap(
                                        bottomModel: controller.pages[index],
                                        isActive: index == controller.pageIndex,
                                      )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    controller.changePageIndex(index);

                                    controller.startanimate(index);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 28.0),
                                    child: ShakeAnimatedWidget(
                                      enabled: controller.animate[index],
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      shakeAngle: Rotation.deg(z: 40),
                                      curve: Curves.linear,
                                      child: SvgPicture.asset(
                                        index == controller.pageIndex
                                            ? controller.pages[index].activeIcon
                                            : controller.pages[index].inActiveIcon,
                                      ),
                                    ),
                                  ),
                                )),
                    ),
                  ))
            ],
          ));
        });
  }
}

class BottomModel {
  Widget page;
  String activeIcon;
  String inActiveIcon;

  BottomModel(
      {required this.page,
      required this.inActiveIcon,
      required this.activeIcon});
}
