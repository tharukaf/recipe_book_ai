import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Center(
            child: SizedBox(
              width: constraints.maxWidth * 0.7,
              child: child,
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
