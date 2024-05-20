library fancy_button;

import 'package:fancy_button/line_gradient_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'line_gradient_text.dart';

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
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
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
                    5.0 / 7.0: const Color(0xFFFFB508),
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
                Expanded(
                  child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return LinearGradientText(
                          widget.titleText,
                          subtitleText: widget.subtitleText,
                          gradientStops: {
                            0.0 / 5.0: const Color(0xFF272727),
                            1.0 / 5.0: const Color(0xFF272727),
                            2.0 / 5.0: const Color(0xFFFFFFFF),
                            3.0 / 5.0: const Color(0xFFFFFFFF),
                            4.0 / 5.0: const Color(0xFF272727),
                            5.0 / 5.0: const Color(0xFF272727),
                          },
                          gradientScaleX: 14.0,
                          gradientOffsetX:
                              (_animation.value) * (1.0 - 1 / 14.0),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
