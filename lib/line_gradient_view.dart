import 'dart:math' as math;

import 'package:flutter/material.dart';

class LinearGradientView extends StatelessWidget {
  final BorderRadius borderRadius;
  final double blurRadius;
  final double spreadRadius;
  final Map<double, Color> gradientStops;
  final double? gradientRotation;
  final double? gradientScaleX;
  final double? gradientScaleY;
  final double? gradientOffsetX;
  final double? gradientOffsetY;

  const LinearGradientView({
    super.key,
    required this.gradientStops,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.gradientRotation,
    this.gradientScaleX,
    this.gradientScaleY,
    this.gradientOffsetX,
    this.gradientOffsetY,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientShadowPainter(
        gradientStops,
        borderRadius: borderRadius,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        rotation: gradientRotation,
        scaleX: gradientScaleX ?? 1.0,
        scaleY: gradientScaleY ?? 1.0,
        offsetX: gradientOffsetX,
        offsetY: gradientOffsetY,
      ),
      size: Size.infinite,
    );
  }
}

class GradientShadowPainter extends CustomPainter {
  final BorderRadius? borderRadius;
  final double? spreadRadius;
  final Shadow? shadow;
  final LinearGradient gradient;
  final double scaleX;
  final double scaleY;

  GradientShadowPainter(
    Map<double, Color> gradientStops, {
    double? blurRadius,
    this.spreadRadius,
    this.borderRadius,
    this.scaleX = 1.0,
    this.scaleY = 1.0,
    double? offsetX,
    double? offsetY,
    double? rotation,
  })  : gradient = LinearGradient(
            colors: gradientStops.values.toList(),
            stops: gradientStops.keys.toList(),
            transform: GradientOffsetRotation.from(offsetX, offsetY, rotation)),
        shadow = blurRadius != null ? Shadow(blurRadius: blurRadius) : null;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = (Offset.zero & size).inflate(spreadRadius ?? 0.0);

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(
          rect.left, rect.top, rect.width * scaleX, rect.height * scaleY));

    if (shadow != null) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, shadow!.blurSigma);
    }

    if (borderRadius != null) {
      final path = Path()..addRRect(borderRadius!.toRRect(rect));
      canvas.drawPath(path, paint);
    } else {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(GradientShadowPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(GradientShadowPainter oldDelegate) => false;
}

class GradientOffsetRotation extends GradientTransform {
  final double offX;
  final double offY;
  final double radians;

  const GradientOffsetRotation(this.offX, this.offY, this.radians);

  static GradientOffsetRotation? from(
      double? offX, double? offY, double? radians) {
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
    final double originX = sinRadians * center.dy +
        oneMinusCosRadians * center.dx -
        bounds.width * offX;
    final double originY = -sinRadians * center.dx +
        oneMinusCosRadians * center.dy -
        bounds.height * offY;

    return Matrix4.identity()
      ..translate(originX, originY)
      ..rotateZ(radians);
  }
}
