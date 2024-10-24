import 'package:flutter/material.dart';

class ClickableItem extends StatelessWidget {
  final void Function() onLongPress;
  final void Function() onPressed;
  final Widget child;

  const ClickableItem({
    super.key,
    required this.onPressed,
    required this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.all(0),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
