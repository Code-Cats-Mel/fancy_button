library fancy_button;

import 'package:fancy_button/line_gradient_view.dart';
import 'package:flutter/material.dart';

import 'animated_gradient_view.dart';
import 'gradient_background_view.dart';

class FancyButton extends StatefulWidget {
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
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (false)
          GradientBackgroundView(
            {
              0.0: const Color(0xFFFF3D00),
              1.0: const Color(0xFFFF00F5),
            },
            borderRadius: widget.borderRadius,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        if (false)
          AnimatedGradientView({
            0.0 / 7.0: const Color(0xFFFFB404),
            1.0 / 7.0: const Color(0xFFFFDF80),
            2.0 / 7.0: const Color(0xFFFF7E7F),
            3.0 / 7.0: const Color(0xFFC728FF),
            4.0 / 7.0: const Color(0xFFF872DC),
            5.0 / 7.0: const Color(0xFFFFDF80),
            6.0 / 7.0: const Color(0xFFFFB508),
          },
              colorsRepeatNumber: 14.0,
              blurRadius: 0,
              borderRadius: widget.borderRadius),
        if (true)
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearGradientView(
                  borderRadius: widget.borderRadius,
                  blurRadius: 8,
                  spreadRadius: 2,
                  gradientRotation: _animation.value * 3.14 * 2,
                  gradientStops: {
                    0.0: const Color(0xFFFF3D00),
                    1.0: const Color(0xFFFF00F5),
                  },
                );
              }),
        if (true)
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearGradientView(
                  borderRadius: widget.borderRadius,
                  gradientScaleX: 14,
                  gradientOffsetX: (_animation.value) * (1.0 - 1 / 14.0),
                  gradientStops: {
                    0.0 / 7.0: const Color(0xFFFFB404),
                    1.0 / 7.0: const Color(0xFFFFDF80),
                    2.0 / 7.0: const Color(0xFFFF7E7F),
                    3.0 / 7.0: const Color(0xFFC728FF),
                    4.0 / 7.0: const Color(0xFFF872DC),
                    5.0 / 7.0: const Color(0xFFFFDF80),
                    6.0 / 7.0: const Color(0xFFFFB508),
                  },
                );
              }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              if (widget.icon != null)
                SizedBox(
                  width: 40,
                  height: 40,
                  child: widget.icon,
                ),
              ShaderMask(
                shaderCallback: (rect) => const LinearGradient(
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFF0000F5),
                  ],
                ).createShader(rect),
                blendMode: BlendMode.srcATop,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.titleText != null)
                      Text(
                        widget.titleText!,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                    if (widget.subtitleText != null)
                      Text(
                        widget.subtitleText!,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
