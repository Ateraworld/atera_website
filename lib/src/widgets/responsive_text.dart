import "package:atera_website/src/common/layout.dart";
import "package:flutter/material.dart";

class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.text, {
    super.key,
    this.sizeFactor = 2,
    this.style,
    this.textAlign,
    this.max = double.infinity,
    this.min = 0,
  });
  final double max;

  final double min;

  final TextAlign? textAlign;
  final TextStyle? style;
  final double sizeFactor;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: _getStyle(context),
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    var res = style ?? Theme.of(context).textTheme.bodyMedium;
    return res?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactor, min: min, max: max));
  }
}
