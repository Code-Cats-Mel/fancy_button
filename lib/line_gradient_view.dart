import 'package:flutter/material.dart';

class LinearGradientView extends StatelessWidget {
  final BorderRadius borderRadius;
  final double blurRadius;
  final double spreadRadius;
  final Map<double, Color> gradientStops;
  final double? rotation;

  const LinearGradientView({
    super.key,
    required this.gradientStops,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientShadowPainter(
        gradientStops,
        borderRadius: borderRadius,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        rotation: rotation,
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

  GradientShadowPainter(
    Map<double, Color> gradientStops, {
    double? blurRadius,
    this.spreadRadius,
    this.borderRadius,
    double? rotation,
  })  : gradient = LinearGradient(
            colors: gradientStops.values.toList(),
            stops: gradientStops.keys.toList(),
            transform: rotation != null ? GradientRotation(rotation) : null),
        shadow = blurRadius != null ? Shadow(blurRadius: blurRadius) : null;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = (Offset.zero & size).inflate(spreadRadius ?? 0.0);

    final paint = Paint()..shader = gradient.createShader(bounds);

    if (shadow != null) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, shadow!.blurSigma);
    }

    if (borderRadius != null) {
      final path = Path()..addRRect(borderRadius!.toRRect(bounds));
      canvas.drawPath(path, paint);
    } else {
      canvas.drawRect(bounds, paint);
    }
  }

  @override
  bool shouldRepaint(GradientShadowPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(GradientShadowPainter oldDelegate) => false;
}
