import "dart:math";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

double dimensionFromSizeFactor(
  BuildContext context,
  double sizeFactor, {
  double max = double.infinity,
  double min = 0,
}) {
  var factor = pow(MediaQuery.of(context).size.width, 0.7) * 0.035;
  return clampDouble(factor * sizeFactor, min, max);
}
