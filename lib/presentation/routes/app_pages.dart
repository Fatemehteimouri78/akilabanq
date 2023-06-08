import 'package:akilabanq/presentation/pages/auth/controller/generate_seed.dart';
import 'package:akilabanq/presentation/pages/auth/controller/verify_seed_controller.dart';
import 'package:akilabanq/presentation/pages/auth/created_wallet_page.dart';
import 'package:akilabanq/presentation/pages/auth/verify_seed.dart';
import 'package:akilabanq/presentation/pages/setting/controller/information_onboarding_controller.dart';
import 'package:akilabanq/presentation/pages/setting/controller/setting_controller.dart';
import 'package:akilabanq/presentation/pages/setting/lock_screen/lock_screen_controller.dart';
import 'package:akilabanq/presentation/pages/setting/lock_screen/lock_screen_page.dart';
import 'package:akilabanq/presentation/pages/setting/setting_view.dart';
import 'package:akilabanq/presentation/pages/splash/controller/intro_controller.dart';
import 'package:akilabanq/presentation/pages/splash/controller/splash_controller.dart';
import 'package:akilabanq/presentation/pages/splash/intro_page.dart';
import 'package:akilabanq/presentation/pages/splash/splash_view.dart';
import 'package:akilabanq/presentation/pages/wallet/controller/token_transactions_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/token_transactions.dart';
import 'package:get/get.dart';

import '../pages/auth/generate_seed.dart';
import '../pages/home/controller/home_controller.dart';
import '../pages/home/home_view.dart';
import '../pages/setting/profile/personal_information/information_onboarding.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.home,
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),

      page: () => const HomeView(),
      // binding: HomeBinding(),
      // children: [
      //   GetPage(
      //     name: Routes.COUNTRY,
      //     page: () => CountryView(),
      //     children: [
      //       GetPage(
      //         name: Routes.DETAILS,
      //         page: () => DetailsView(),
      //       ),
      //     ],
      //   ),
      // ],
    ),
    GetPage(
      name: Routes.splash,
      binding: BindingsBuilder(() => Get.lazyPut(() => SplashController())),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut<HomeController>(() => HomeController());
      //
      // }),

      page: () => const SplashView(),
    ),

    // binding: HomeBinding(),
    // children: [
    //   GetPage(
    //     name: Routes.COUNTRY,
    //     page: () => CountryView(),
    //     children: [
    //       GetPage(
    //         name: Routes.DETAILS,
    //         page: () => DetailsView(),
    //       ),
    //     ],
    //   ),
    // ],

    GetPage(name: Routes.lockScreen, binding: BindingsBuilder(() => Get.lazyPut(() => LockScreenPageController())), page: () => LockScreenPage()),
    GetPage(name: Routes.created_wallet, page: () => CreatedWalletPage()),
   
    GetPage(
      name: Routes.setting,
      binding: BindingsBuilder(() => Get.lazyPut(() => SettingController())),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut<HomeController>(() => HomeController());
      //
      // }),

      page: () => const SettingView(),
    ),
    GetPage(
      name: Routes.informationOnboarding,
      binding: BindingsBuilder(() {
        Get.lazyPut<InformationOnboardingController>(() => InformationOnboardingController());
      }),
      page: () => InformationOnboarding(),
    ),
    GetPage(
      name: Routes.intro_page,
      binding: BindingsBuilder(() {
        Get.lazyPut<IntroPageController>(() => IntroPageController());
      }),
      page: () => IntroPage(),
    ),
    GetPage(
        name: Routes.verifySeeds,
        page: () => VerifySeedsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VerifySeedsPageController());
        })),
    GetPage(
      name: Routes.generateSeeds,
      binding: BindingsBuilder(() {
        Get.lazyPut<GenerateSeedsPageController>(() => GenerateSeedsPageController());
      }),
      page: () => GenerateSeedsPage(),
    )
  ];
}
