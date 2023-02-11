import "dart:math";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

double dimensionFromSizeFactor(
  BuildContext context,
  double sizeFactor, {
  double max = double.infinity,
  double min = 0,
}) {
  var factor = pow(MediaQuery.of(context).size.width, 0.65) * 0.035;
  return clampDouble(factor * sizeFactor, min, max);
}

enum TextCategory { title, header, body, label, caption }

double sizeFactorFromCategory(TextCategory category) {
  switch (category) {
    case TextCategory.title:
      return 14;
    case TextCategory.header:
      return 8;
    case TextCategory.body:
      return 5;
    case TextCategory.label:
      return 4;
    case TextCategory.caption:
      return 3;
  }
}
