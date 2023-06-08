import 'package:akilabanq/presentation/pages/home/controller/home_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/controller/token_transactions_controller.dart';
import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:akilabanq/presentation/pages/wallet/token_transactions.dart';
import 'package:akilabanq/presentation/routes/app_pages.dart';
import 'package:akilabanq/utils/widgets/cached_image.dart';
import 'package:akilabanq/utils/widgets/server_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/constant/color.dart';
import '../../../../utils/cutom_neumero.dart';
import 'coin_text.dart';

class CoinCart extends StatelessWidget {
  CoinCart({required this.token});
  final TokenModel token;
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.put(TokenTransactionController()).setTokenModel(token);
        controller.changePageIndex(5);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        decoration: BoxDecoration(color: Colors.transparent, border: Border(bottom: BorderSide(color: AppColors.darkGrey.withOpacity(.1)))),
        width: double.infinity,
        height: 80,
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            const Gap(1.5),
            RoundReactNeumorophic(
              depth: 3,
              isCircle: false,
              radius: BorderRadius.circular(10),
              lightSource: const LightSource(-1.5, -1),
              padding: 0,
              child: Container(
                width: 45,
                height: 45,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                child: Transform.scale(
                    scale: .5,
                    child: cachedImage(
                      token.icon,
                    )
                    // SvgPicture.network(
                    //   token.icon,
                    //   // Assets.icons.svg.bitcoin,
                    //   width: 10,
                    //   color: Colors.red,
                    //   fit: BoxFit.contain,
                    // )
                    ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CointText(
                    textOne: token.name,
                    textTwo: token.type == 'token' ? "(${token.network})" : '',
                    textThree: "\$${token.price}",
                    isRich: true,
                  ),
                  CointText(textOne: token.balance.toString(), textTwo: token.symbol, textThree: "\$${token.tokenValue}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
