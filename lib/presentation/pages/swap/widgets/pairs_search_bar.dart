import 'package:akilabanq/presentation/pages/swap/controller/swap_controler.dart';
import 'package:akilabanq/presentation/pages/swap/models/pairs_model.dart';
import 'package:akilabanq/presentation/pages/wallet/widgets/coin_text.dart';
import 'package:akilabanq/utils/constant/text_style.dart';

import 'package:akilabanq/utils/widgets/cached_image.dart';
import 'package:akilabanq/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PairsSearchDelegate extends SearchDelegate {
  PairsSearchDelegate({required this.pairs, required this.isFromPair});

  late List<PairsModel> pairs = [];
  final bool isFromPair;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.delete))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<PairsModel> machQuery = [];
    for (var pair in pairs) {
      if (pair.senderName!.toLowerCase().contains(query.toLowerCase())) {
        machQuery.add(pair);
      }
    }
    return ListView.builder(
        itemCount: machQuery.length,
        itemBuilder: (context, index) {
          var result = machQuery[index];
          return ListTile(
            title: Text(
              result.senderName.toString(),
              style: const TextStyle(color: Colors.green),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PairsModel> machQuery = [];
    for (var pair in pairs) {
      if (pair.senderName!.toLowerCase().contains(query.toLowerCase())) {
        machQuery.add(pair);
      }
    }
    return pairs.isEmpty
        ? Center(
            child: Loading(),
          )
        : ListView.builder(
            itemCount: machQuery.length,
            itemBuilder: (context, index) {
              PairsModel currentPair = pairs[index];
              var result = machQuery[index];
              return InkWell(
                onTap: () {
                  isFromPair
                      ? {
                          Get.find<SwapController>().setToPairs(currentPair.fromId),
                          Get.back(),
                          showSearch(context: context, delegate: PairsSearchDelegate(pairs: Get.find<SwapController>().toPairs, isFromPair: false))
                        }
                      : {Get.find<SwapController>().changeCurrentPair(currentPair)};
                },
                child: Card(
                    child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      cachedImage(isFromPair ? currentPair.senderIcon : currentPair.receiverIcon, height: 40),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              textDirection: TextDirection.ltr,
                              text: TextSpan(
                                  text: isFromPair ? currentPair.senderName! : currentPair.receiverName!,
                                  style: AppTextStyles.dark_14_w700,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " ${isFromPair ? currentPair.senderToken!.network:currentPair.receiverToken!.network}",
                                      style: AppTextStyles.dark_14_w300,
                                    )
                                  ])),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            isFromPair ? currentPair.senderSym! : currentPair.receiverSym!,
                            style: AppTextStyles.black_11_w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              );
            });
  }
}
