import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/scalable.dart";
import "package:flutter/material.dart";

class ScalableIconButton extends StatelessWidget {
  const ScalableIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size,
  });
  final double? size;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scalable(
      factor: 0.125,
      child: IconButton(
        iconSize: size ?? dimensionFromSizeFactor(context, 20),
        icon: Icon(icon),
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
