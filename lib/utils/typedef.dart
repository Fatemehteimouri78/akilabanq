import 'package:flutter/material.dart';

typedef StringListCallback = void Function(List<String>);
typedef BoolAsyncCallback = Future<bool> Function();
typedef BoolCallback = void Function(bool flag);
typedef StringCallback = void Function(String);
typedef IntCallback = void Function(int);
typedef DoubleCallback = void Function(double);
typedef RangeValuesCallback = void Function(RangeValues);
typedef VoidCallback = void Function();
typedef FutureCallback = Future Function();
