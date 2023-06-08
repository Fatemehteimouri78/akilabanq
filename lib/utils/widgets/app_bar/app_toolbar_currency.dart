import 'package:flutter/material.dart';

import 'app_toolbar.dart';
import 'currency_type_widget.dart';

class AppToolbarCurrency extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? titleColor;

  const AppToolbarCurrency({Key? key, this.title = '', this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppToolbar(
      title: title,
      titleColor: titleColor,
      actions: const [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}