import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading({this.alignment = Alignment.center});

  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return   Center(

      child: Align(
        alignment: alignment,
        child: SizedBox(
          width: 80,
          child: SpinKitThreeBounce (
            color: Colors.blueGrey,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
