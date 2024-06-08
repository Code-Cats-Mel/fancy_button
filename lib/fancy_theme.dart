library fancy_gradient_button;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FancyButtonTheme {
  final double borderRadius;
  final double spreadRadius;
  final double gradientScaleX;
  final Gradient backgroundShadowGradient;
  final double backgroundShadowRotationSpeedFactor;
  final Gradient backgroundGradient;
  final Gradient textGradient;

  const FancyButtonTheme({
    this.borderRadius = 8.0,
    this.spreadRadius = 2.0,
    required this.gradientScaleX,
    required this.backgroundShadowGradient,
    this.backgroundShadowRotationSpeedFactor = 1.0,
    required this.backgroundGradient,
    required this.textGradient,
  });

  static const FancyButtonTheme standard = FancyButtonTheme(
    borderRadius: 8,
    spreadRadius: 2,
    gradientScaleX: 14,
    backgroundShadowGradient: LinearGradient(
      colors: [
        Color(0xFFFF3D00),
        Color(0xFFFF00F5),
      ],
    ),
    backgroundShadowRotationSpeedFactor: 3.0,
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xFFFFB404),
        Color(0xFFFFDF80),
        Color(0xFFFF7E7F),
        Color(0xFFC728FF),
        Color(0xFFF872DC),
        Color(0xFFFFDF80),
        Color(0xFFFFB508),
      ],
    ),
    textGradient: LinearGradient(
      colors: [
        Color(0xFF272727),
        Color(0xFF272727),
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
        Color(0xFF272727),
        Color(0xFF272727),
      ],
    ),
  );

  static const FancyButtonTheme elite = FancyButtonTheme(
    borderRadius: 8,
    spreadRadius: 2,
    gradientScaleX: 14,
    backgroundShadowGradient: LinearGradient(
      colors: [
        Color(0xFF9013FE),
        Color(0xFF4F0051),
      ],
    ),
    backgroundShadowRotationSpeedFactor: 3.0,
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xFF461455),
        Color(0xFF9C245E),
        Color(0xFF6D1772),
        Color(0xFF8C1280),
        Color(0xFF6E1B6F),
        Color(0xFF2C1360),
        Color(0xFF1D091C),
      ],
    ),
    textGradient: LinearGradient(
      colors: [
        Color(0xFFEBEBEB),
        Color(0xFFE4E4E4),
        Color(0xFFBBBBBB),
        Color(0xFFFFFFFF),
        Color(0xFFF5F5F5),
        Color(0xFFECECEC),
        Color(0xFFD2D2D2),
      ],
    ),
  );
}
