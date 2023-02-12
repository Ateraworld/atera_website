import "package:flutter/material.dart";

/// Make any widget tappable and make it display an [InkWell] when tapped
class Tappable extends StatelessWidget {
  const Tappable({
    super.key,
    required this.onTap,
    required this.child,
    this.heroTag,
    this.size,
    this.borderRadius,
  });
  final Size? size;
  final BorderRadiusGeometry? borderRadius;
  final Object? heroTag;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: SizedBox(
        width: size?.height,
        height: size?.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (heroTag != null)
              Positioned.fill(
                child: Hero(
                  tag: heroTag!,
                  child: child,
                ),
              )
            else
              Positioned.fill(child: child),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
