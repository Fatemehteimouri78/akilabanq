import 'package:akilabanq/presentation/pages/swap/models/exchange_model.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/constant/color.dart';
import '../../../../utils/constant/text_style.dart';
import '../../../../utils/cutom_neumero.dart';

class TransActionCard extends StatelessWidget {
  const TransActionCard({super.key, required this.index , required this.exchange });
  final int index;
  final ExchangeModel exchange;


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              top: BorderSide(color: AppColors.darkGrey.withOpacity(index==0?0:.1)))),
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Gap(1.5),
          RoundReactNeumorophic(
            depth: 3,
            isCircle: false,
            radius: BorderRadius.circular(10),
            lightSource: const LightSource(-1.5, -1),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(10)),
              child: Transform.scale(
                  scale: .5,
                  child: SvgPicture.asset(
                    Assets.icons.svg.tradeActive,
                    width: 10,
                    color: Colors.red,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          const Gap(20),
           TransActionText(
            from: "${exchange.inValue.toString()} ",
            to: "${exchange.outValue} AKL",
            status: exchange.status,

            date: exchange.updatedAt.toString(),
            isRich: true,
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class TransActionText extends StatelessWidget {
  const TransActionText({Key? key,
    required this.from,
    required this.to,
    required this.status,
    required this.date,
    this.isRich = false})
      : super(key: key);
  final String from;
  final String to;
  final String status;
  final String date;

  final bool isRich;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Text(from,style: AppTextStyles.dark_12_w500,),
            const Gap(6),

            Icon(Icons.arrow_forward,color: AppColors.primary2.withOpacity(.5),size: 20,),
            const Gap(6),

            Text(to,style: AppTextStyles.dark_12_w500,)
          ],
        ),
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(Assets.icons.svg.vector2),
            const Gap(7),

            Text(status,style: AppTextStyles.dark_10_w500,),
            const Gap(10),


            Text(date,style: AppTextStyles.dark_10_w300,),
          ],
        ),


      ],
    );
  }
}
