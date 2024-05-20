import 'package:flutter/material.dart';

import 'gradient_offset_rotation.dart';

class LinearGradientText extends StatelessWidget {
  final String titleText;
  final String? subtitleText;
  final Map<double, Color> gradientStops;

  final double? gradientScaleX;
  final double? gradientScaleY;
  final double? gradientOffsetX;
  final double? gradientOffsetY;

  const LinearGradientText(
    this.titleText, {
    required this.gradientStops,
    this.subtitleText,
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
        colors: gradientStops.values.toList(),
        stops: gradientStops.keys.toList(),
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
          if (true)
            Text(
              titleText,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          if (subtitleText != null)
            Text(
              subtitleText!,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
        ],
      ),
    );
  }
}
