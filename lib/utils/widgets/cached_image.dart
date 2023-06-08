import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:extended_image/extended_image.dart';

Widget cachedImage(url, {double? height, double? width, bool showLoading = true, bool hasBackgroundColor = true, bool cache = true, boxFit}) {
  return ExtendedImage.network(
    url,
    cache: cache,
    fit: boxFit ?? BoxFit.fill,
    gaplessPlayback: true,
    height: height,
    width: width,
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          // _controller.reset();

          return Container(
            child: showLoading
                ? const SpinKitThreeBounce(
                    color: Colors.grey,
                    size: 25.0,
                  )
                : Container(),
          );
        case LoadState.failed:
        state.reLoadImage();
          // _controller.reset();
          //remove memory cached
          state.imageProvider.evict();
          return GestureDetector(
            child: Container(
              child: const Center(
                  child: Icon(
                Icons.error_outline,
                color: Colors.grey,
              )),
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
        case LoadState.completed:
          // TODO: Handle this case.
          break;
      }
    },
  );
}
