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
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _animationController.forward();

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.repeat();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
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
                  rotation: _animation.value * 3.14 * 2,
                  gradientStops: {
                    // 0.0: const Color(0xFF000000),
                    // 1.0: const Color(0xFFFF0000),
                    0.0: const Color(0xFFFF3D00),
                    1.0: const Color(0xFFFF00F5),
                  },
                );
              }),
      ],
    );
  }
}
