import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:akilabanq/utils/widgets/app_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

extension DoubleExt on double {
  Future<Duration> secondsDelay() async => Future.delayed(seconds());

  Duration seconds() => Duration(milliseconds: (this * 1000).toInt());
}

extension IntegersExt on int {
  Future<Duration> secondsDelay() async => Future.delayed(seconds());

  Duration seconds() => Duration(seconds: this);

  String commaSeparated() => toString().commaSeparated();

  // String humanReadable() => NumberFormat.compact().format(this);

  bool get isOdd => this % 2 == 1;

  bool get isOk => this >= 200 && this < 300;

  bool get isClientError => this >= 400 && this < 500;

  bool get isServerError => this >= 500;

  String asPeriodName() {
    if (this == 1) {
      return 'زنگ اول';
    } else if (this == 2) {
      return 'زنگ دوم';
    } else if (this == 3) {
      return 'زنگ سوم';
    } else if (this == 4) {
      return 'زنگ چهارم';
    } else if (this == 5) {
      return 'زنگ پنجم';
    } else {
      return toString();
    }
  }
}

extension StringExt on String {
  bool isNumeric() => num.tryParse(this) != null;

  bool containsAnyOf(List<String> matches) {
    var result = false;
    for (var match in matches) {
      if (contains(match)) result = true;
    }
    return result;
  }

  String kb2Mb() {
    var num = int.tryParse(this);
    if (num == null) {
      return this;
    } else {
      num = (num / 1000000).floor();
      return '${num}MB';
    }
  }

  String take(int count) {
    if (length > count) {
      return substring(0, count);
    } else {
      return this;
    }
  }

  String ellipsize(int count) {
    if (length > count) {
      return '${substring(0, count)} ...';
    } else {
      return this;
    }
  }

//   String fixUnicodeEscaped() {
//     //for characters with \\ like -> \\u044F
// //    final RegExp r = RegExp(r'\\\\u([0-9a-fA-F]+)');
//
//     //for characters with \ like -> \\u044F
//     final RegExp r = RegExp(r'\\u([0-9a-fA-F]+)');
//
//     // Sample string to parse.
// //    final String source =
// //        r'\\u0414\\u043B\\u044F \\u043F\\u0440\\u043E\\u0434\\u0430\\u0436\\u0438 \\u043D\\u0435\\u0434\\u0432\\u0438\\u0436\\u0438\\u043C\\u043E\\u0441\\u0442\\u0438';
//
//     // Replace each \u0123 with the decoded codepoint.
//     final String decoded = this.replaceAllMapped(r, (Match m) {
//       // Extract the parenthesised hex string. '\\u0123' -> '123'.
//       final String hexString = m.group(1);
//
//       // Parse the hex string to an int.
//       final int codepoint = int.parse(hexString, radix: 16);
//
//       // Convert codepoint to string.
//       return String.fromCharCode(codepoint);
//     });
//     return decoded;
//   }

  // void go([arguments]) {
  //   sailor.navigate(this, args: arguments);
  // }

  Future launchUrl() async {
    print(this);
    if (await canLaunch(this)) {
      return launch(this, forceSafariVC: false);
    } else {
      return null;
    }
  }

  String removePlus98() {
    return replaceFirst('+98', '');
  }

  bool get isValidUrl => Uri.parse(this).isAbsolute;

  bool get isValidEmail => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  String commaSeparated() {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    String result = replaceAllMapped(reg, mathFunc);
    return result;
  }

  int? findFirstNumber() {
    for (var i = 0; i < length; i++) {
      var character = this[i];
      if (isNumeric()) {
        return int.tryParse(character);
      }
    }
    return null;
  }

  bool get isNullOrBlank => trim().isEmpty;

  bool get isNotNullOrBlank => !isNullOrBlank;

  String swapFaNumericToEn() {
    var result = this;
    var numbersFa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var numbersEn = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    for (var i = 0; i < result.length; i++) {
      var character = result[i];
      for (var j = 0; j < numbersFa.length; j++) {
        if (character == numbersFa[j]) {
          result = result.replaceFirst(character, numbersEn[j], i);
        }
      }
    }
    return result;
  }
}

extension MapExt<T, S> on Map<T, S> {
  Map<T, S> clone() => map((key, value) => MapEntry(key, value));

  bool hasKeyWithValue(T key, S value) {
    if (containsKey(key)) {
      if (this[key] == value) {
        return true;
      }
    }
    return false;
  }
}

extension ListExt<T> on List<T> {
  List<List<T>> split(int count) {
    var cloneList = toList();
    List<List<T>> list = [];
    if (cloneList.isNotEmpty) {
      while (cloneList.isNotEmpty) {
        List<T> partition = [];
        for (var i = 0; i < count; i++) {
          if (cloneList.isNotEmpty) {
            partition.add(cloneList.removeAt(0));
          }
        }
        if (partition.isNotEmpty) list.add(partition);
      }
    }
    return list;
  }

  List<T> copyWith(List<T> newItems,
  {required bool Function(T old, T neww) replaceWhere}) {
  var cloneList = toSet().toList();
  for (var newItem in newItems) {
  for (var i = 0; i < cloneList.length; i++) {
  var oldItem = cloneList[i];
  if (replaceWhere(oldItem, newItem)) {
  cloneList.removeAt(i);
  cloneList.insert(i, newItem);
  }
  }
  }
  return cloneList;
  }

  bool containsAnyOf(List<T> matches) {
  var result = false;
  for (var item in this) {
  for (var match in matches) {
  if (item == match) result = true;
  }
  }
  return result;
  }

  List<T> clone() => List.of(this);

  List<T> removeDuplicates(int Function(T a) getUnicId) {
  final Set<int> ids = map((item) => getUnicId(item)).toSet();
  List<T> cloneList = map((item) => item).toList();
  cloneList.retainWhere((x) => ids.remove(getUnicId(x)));
  return cloneList.toList();
  }

  T? get firstOrNull {
  if (isNotEmpty == true) {
  return first;
  } else {
    return null;
  }
  }

  void printItems([String Function(T t)? print]) {
  log('======================================================');
  for (var i = 0; i < length; i++) {
  var item = this[i];
  (print == null) ? log('\n $item \n') : log('\n ${print(item)} \n');
  }
  log('======================================================');
  }

  bool get isNotNulOrEmpty => isNotNullOrEmpty(this);

  bool get isNullOrEmpty => !isNotNullOrEmpty(this);
}

//##################################### utility functions #####################################
//##################################### utility functions #####################################

bool isNotNullOrEmpty<T>(List<T> list) {
  if (list == null) {
    return false;
  } else if (list.isEmpty) {
    return false;
  } else {
    return true;
  }
}

// Future<bool> check() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   }
//   return false;
// }

void report(e, stacktrace) {
//   if (e is AppException) {
//     if (!e.isReported && e.shouldBeReported) {
//       e.isReported = true;
// //        Crashlytics.instance.recordError(e, stacktrace);
//     }
//   } else {
// //      Crashlytics.instance.recordError(e, stacktrace);
  // }
  if (!kReleaseMode) {
    print(e);
    print(stacktrace);
  }
}

// showActionToast({
//   @required BuildContext context,
//   @required String msg,
//   @required String actionLabel,
//   @required VoidCallback action,
//   double length: 4,
// }) {
//   Flushbar<bool> flush;
//   flush = Flushbar<bool>(
//     messageText: SizedBox(
//       height: 60,
//       child: Text(msg, style: TextStyles.white_16),
//     ),
//     animationDuration: 0.seconds(),
//     margin: const EdgeInsets.only(bottom: 64, right: 20, left: 20, top: 10),
//     borderRadius: 8,
//     mainButton: Column(
//       children: [
//         SizedBox(height: 40),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: GestureDetector(
//             onTap: () => flush.dismiss(true),
//             behavior: HitTestBehavior.opaque,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(actionLabel, style: TextStyle(color: AppColors.THEME_ACCENT)),
//             ),
//           ),
//         ),
//       ],
//     ),
//     backgroundColor: Colors.black,
//     // flushbarPosition: FlushbarPosition.TOP,
//     isDismissible: false,
//     duration: length.seconds(),
//   )..show(context).then((value) {
//       if (value != null) action?.call();
//     });
// }

void showSuccessToast(String msg, {bool lengthLong = true}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: Colors.green,
    toastLength: lengthLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
  );
}

void showInfoToast(String msg, {bool lengthLong = true}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.black,
    backgroundColor: Colors.amberAccent,
    toastLength: lengthLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
  );
}

void showWarningToast(String msg,
    {bool lengthLong = true, ToastGravity? gravity}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    gravity: gravity ?? ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: Colors.redAccent,
    toastLength: lengthLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
  );
}

String convertMoney(double amount, {int digits = 4}) {
  return NumberFormat.currency(
      locale: 'en_US', symbol: '', decimalDigits: digits)
      .format(amount);
}

// void showSuccessToast(String msg, {bool lengthLong = true}) {
//   try {
//     Fluttertoast.cancel();
//   } catch (e) {
//     //do nothing
//   }
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: lengthLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
//     fontSize: 16,
//     textColor: AppColors.THEME_GREEN,
//     backgroundColor: AppColors.THEME_GREEN_LIGHT,
//     gravity: ToastGravity.BOTTOM,
//   );
//   // Flushbar<bool>(
//   //   messageText: Text(msg, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.THEME_GREEN)),
//   //   animationDuration: 0.seconds(),
//   //   margin: const EdgeInsets.only(bottom: 80, right: 20, left: 20, top: 10),
//   //   borderRadius: 8,
//   //   backgroundColor: AppColors.THEME_GREEN_LIGHT,
//   //   flushbarPosition: FlushbarPosition.TOP,
//   //   isDismissible: false,
//   //   duration: 3.5.seconds(),
//   //   borderWidth: 1,
//   // ).show(context);
// }
//
// void showInfoToast(String msg, {bool lengthLong = true}) {
//   try {
//     Fluttertoast.cancel();
//   } catch (e) {
//     //do nothing
//   }
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: lengthLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
//     fontSize: 16,
//     textColor: AppColors.THEME_ORANGE,
//     backgroundColor: AppColors.THEME_ORANGE_LIGHT,
//     gravity: ToastGravity.BOTTOM,
//   );
//   // Flushbar<bool>(
//   //   messageText: Text(msg, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.THEME_ORANGE)),
//   //   animationDuration: 0.seconds(),
//   //   margin: const EdgeInsets.only(bottom: 80, right: 20, left: 20, top: 10),
//   //   borderRadius: 8,
//   //   backgroundColor: AppColors.THEME_ORANGE_LIGHT,
//   //   flushbarPosition: FlushbarPosition.TOP,
//   //   isDismissible: false,
//   //   duration: 3.5.seconds(),
//   //   borderWidth: 1,
//   // ).show(context);
// }
//
// void showWarningToast(String msg, {bool lengthLong = true, ToastGravity gravity}) {
//   try {
//     Fluttertoast.cancel();
//   } catch (e) {
//     //do nothing
//   }
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: lengthLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
//     fontSize: 16,
//     textColor: AppColors.THEME_RED,
//     backgroundColor: AppColors.THEME_RED_LIGHT,
//     gravity: gravity ?? ToastGravity.BOTTOM,
//   );
//   // Flushbar<bool>(
//   //   messageText: Text(msg, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.THEME_RED)),
//   //   animationDuration: 0.seconds(),
//   //   margin: const EdgeInsets.only(bottom: 80, right: 20, left: 20, top: 10),
//   //   borderRadius: 8,
//   //   backgroundColor: AppColors.THEME_RED_LIGHT,
//   //   flushbarPosition: FlushbarPosition.TOP,
//   //   isDismissible: false,
//   //   duration: 3.5.seconds(),
//   //   borderWidth: 1,
//   // ).show(context);
// }

void showAppModalBottomSheet(
    {required BuildContext context, required String title, Widget? child}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.97,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('    $title'),
                  AppToolbarIconButton(
                      icon: const Icon(Icons.close),
                      onPressed: Navigator.of(context).pop),
                ],
              ),
            ),
            if (child != null) child,
          ],
        ),
      );
    },
  );
}

void showScrollableAppModalButtomSheet(
    {required BuildContext context,
      required String title,
      List<Widget>? children}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.97,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.90,
          maxChildSize: 1,
          minChildSize: 0.90,
          builder: (BuildContext context, ScrollController scrollController) {
            return ListView(
              controller: scrollController,
              children: children ?? [],
            );
          },
        ),
      );
    },
  );
}

double randomDouble(int min, int max) {
  math.Random rnd;
  rnd = math.Random();
  double r = min + rnd.nextInt(max - min).toDouble();
  return r;
}

int randomInt(int min, int max) {
  math.Random rnd;
  rnd = math.Random();
  int r = min + rnd.nextInt(max - min);
  return r;
}

int countSmsPages(String msg) {
  int mode70 = msg.length ~/ 70;
  print(mode70);
  var n = mode70 + 1;
  return n;
}

String calculateChosenRange(int startingIndex, int endingIndex) {
  if (endingIndex == null) {
    return '-';
  } else {
    return (endingIndex - startingIndex).toString();
  }
}

isNumeric(String string) => num.tryParse(string) != null;

extension FileExt on File {
  String get extension => basename(path).split('.').last;
}
