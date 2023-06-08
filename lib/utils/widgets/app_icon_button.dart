import 'package:flutter/material.dart';

class AppIconButton extends AppToolbarIconButton {
  @override
  final Icon icon;
  @override
  final VoidCallback onPressed;

  const AppIconButton({required this.icon, required this.onPressed}) : super(icon: icon, onPressed: onPressed);
}

class AppToolbarIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const AppToolbarIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      splashRadius: 1,
      icon: icon,
      onPressed: onPressed,
    );
  }
}
