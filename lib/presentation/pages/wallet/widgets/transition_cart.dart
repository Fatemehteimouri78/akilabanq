import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../utils/constant/color.dart';
import '../../../../utils/constant/text_style.dart';
import '../../../../utils/cutom_neumero.dart';
import '../model/transactios.dart';

class TransitionCart extends StatelessWidget {
  const TransitionCart({Key? key, required this.transition}) : super(key: key);
  final TransactionModel transition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.extraLightGrey, width: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 52,
            width: 52,
            child: RoundReactNeumorophic(
                radius: BorderRadius.circular(15),
                depth: 7,
                isCircle: false,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(Assets.icons.svg.send),
                )),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transition.from,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.black_12_w300,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          transition.to,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.black_12_w300,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          transition.type == 'receive'
                              ? "+ ${transition.value.toString()}"
                              : "_ ${transition.value.toString()}",
                          style: transition.type == 'receive'
                              ? AppTextStyles.green_14_w600
                              : AppTextStyles.red_14_w600,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          transition.timestamp.toString(),
                          style: AppTextStyles.greylight_10_w300
                              .copyWith(fontSize: 8),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}