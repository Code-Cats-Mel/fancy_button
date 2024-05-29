import 'dart:math' as math;

import 'package:flutter/material.dart';

class GradientOffsetRotation extends GradientTransform {
  final double offX;
  final double offY;
  final double radians;

  const GradientOffsetRotation(this.offX, this.offY, this.radians);

  static GradientOffsetRotation? from(double? offX, double? offY, double? radians) {
    if (offX != null || offY != null || radians != null) {
      return GradientOffsetRotation(offX ?? 0, offY ?? 0, radians ?? 0);
    }
    return null;
  }

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    final double sinRadians = math.sin(radians);
    final double oneMinusCosRadians = 1 - math.cos(radians);
    final Offset center = bounds.center;
    final double originX =
        sinRadians * center.dy + oneMinusCosRadians * center.dx - bounds.width * offX;
    final double originY =
        -sinRadians * center.dx + oneMinusCosRadians * center.dy - bounds.height * offY;

    return Matrix4.identity()
      ..translate(originX, originY)
      ..rotateZ(radians);
  }
}
