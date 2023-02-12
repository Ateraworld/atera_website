import "dart:math";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

double dimensionFromSizeFactor(
  BuildContext context,
  double sizeFactor, {
  double max = double.infinity,
  double min = 0,
  double scalePow = 0.5,
  double scaleConst = 0.085,
}) {
  var factor = pow(MediaQuery.of(context).size.width, scalePow) * scaleConst;
  return clampDouble(factor * sizeFactor, min, max);
}

enum TextCategory { title, header, body, label, caption }

double sizeFactorFromCategory(TextCategory category) {
  switch (category) {
    case TextCategory.title:
      return 22;
    case TextCategory.header:
      return 12;
    case TextCategory.body:
      return 10;
    case TextCategory.label:
      return 7;
    case TextCategory.caption:
      return 4;
  }
}
