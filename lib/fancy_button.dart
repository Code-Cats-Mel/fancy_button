library fancy_button;

import 'package:flutter/material.dart';

import 'animated_gradient_view.dart';
import 'gradient_background_view.dart';

class FancyButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final String? subtitleText;
  final Widget? icon;

  final BorderRadius borderRadius;

  const FancyButton(
    this.titleText, {
    super.key,
    this.onTap,
    this.subtitleText,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackgroundView({
          0.0: const Color(0xFFFF3D00),
          1.0: const Color(0xFFFF00F5),
        }, borderRadius: borderRadius),
        AnimatedGradientView({
          0.0 / 7.0: const Color(0xFFFFB404),
          1.0 / 7.0: const Color(0xFFFFDF80),
          2.0 / 7.0: const Color(0xFFFF7E7F),
          3.0 / 7.0: const Color(0xFFC728FF),
          4.0 / 7.0: const Color(0xFFF872DC),
          5.0 / 7.0: const Color(0xFFFFDF80),
          6.0 / 7.0: const Color(0xFFFFB508),
        }, colorsRepeatNumber: 14.0, blurRadius: 0, borderRadius: borderRadius),
      ],
    );
  }
}
