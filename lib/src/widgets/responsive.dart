import "package:atera_website/src/common/layout.dart";
import "package:flutter/material.dart";

class Responsive extends StatelessWidget {
  const Responsive({super.key, this.sizeFactor = 2, required this.child});
  final Widget child;
  final double sizeFactor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimensionFromSizeFactor(context, sizeFactor),
      height: dimensionFromSizeFactor(context, sizeFactor),
      child: child,
    );
  }
}
