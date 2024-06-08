library fancy_gradient_button;

import 'package:flutter/material.dart';

import 'gradient_offset_rotation.dart';

class LinearGradientText extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Gradient gradient;

  final double? gradientScaleX;
  final double? gradientScaleY;
  final double? gradientOffsetX;
  final double? gradientOffsetY;

  const LinearGradientText(
    this.title, {
    required this.gradient,
    this.subtitle,
    this.gradientScaleX,
    this.gradientScaleY,
    this.gradientOffsetX,
    this.gradientOffsetY,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        colors: gradient.colors,
        stops: gradient.stops,
        transform:
            GradientOffsetRotation.from(gradientOffsetX, gradientScaleY, null),
      ).createShader(Rect.fromLTWH(
          rect.left,
          rect.top,
          rect.width * (gradientScaleX ?? 1.0),
          rect.height * (gradientScaleY ?? 1.0))),
      blendMode: BlendMode.srcATop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title,
          if (subtitle != null) subtitle!,
        ],
      ),
    );
  }
}
