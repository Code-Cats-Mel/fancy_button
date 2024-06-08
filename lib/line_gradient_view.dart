library fancy_gradient_button;

import 'package:flutter/material.dart';

import 'gradient_offset_rotation.dart';

class LinearGradientView extends StatelessWidget {
  final BorderRadius borderRadius;
  final double blurRadius;
  final double spreadRadius;
  final Gradient gradient;
  final double? gradientRotation;
  final double? gradientScaleX;
  final double? gradientScaleY;
  final double? gradientOffsetX;
  final double? gradientOffsetY;

  const LinearGradientView({
    super.key,
    required this.gradient,
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
        gradient,
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
    Gradient gradient, {
    double? blurRadius,
    this.spreadRadius,
    this.borderRadius,
    this.scaleX = 1.0,
    this.scaleY = 1.0,
    double? offsetX,
    double? offsetY,
    double? rotation,
  })  : gradient = LinearGradient(
            colors: gradient.colors,
            stops: gradient.stops,
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
