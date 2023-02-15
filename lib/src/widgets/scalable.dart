import "package:flutter/material.dart";

class Scalable extends StatefulWidget {
  const Scalable({
    super.key,
    required this.child,
    this.durationMs = 200,
    this.curve = Curves.fastOutSlowIn,
    this.factor = 0.075,
  });
  final double factor;
  final Curve curve;
  final int durationMs;
  final Widget child;

  @override
  State<Scalable> createState() => _ScalableState();
}

class _ScalableState extends State<Scalable> {
  double _scale = 1;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _scale = 1 + widget.factor),
      onExit: (event) => setState(() => _scale = 1),
      child: AnimatedScale(
        scale: _scale,
        curve: widget.curve,
        duration: Duration(milliseconds: widget.durationMs),
        child: widget.child,
      ),
    );
  }
}
