library fancy_button;

import 'package:fancy_button/line_gradient_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'line_gradient_text.dart';

class FancyButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String titleText;
  final String? subtitleText;
  final Widget? icon;
  final double? progress;
  final void Function(double progress)? progressCallback;
  final (bool, bool, bool, bool) debugOptions;

  final BorderRadius borderRadius;

  const FancyButton(
    this.titleText, {
    super.key,
    this.onTap,
    this.subtitleText,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.progress,
    this.progressCallback,
    this.debugOptions = const (true, true, true, true),
  });

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> with TickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 10), vsync: this);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 10), vsync: this);

    _checkProgress();
  }

  void _updateProgress() {
    setState(() {});
    widget.progressCallback?.call(_animationController.value);
  }

  @override
  void didUpdateWidget(FancyButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    _checkProgress();
  }

  void _checkProgress() {
    if (widget.progress != null) {
      _animationController.stop();
      _animationController.removeListener(_updateProgress);
      setState(() {
        _animationController.value = widget.progress!;
      });
    } else if (widget.progress == null && !_animationController.isAnimating) {
      _animationController.addListener(_updateProgress);
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _animationController.value;

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Visibility(
            visible: widget.debugOptions.$1,
            child: LinearGradientView(
              borderRadius: widget.borderRadius,
              blurRadius: 8,
              spreadRadius: 4,
              gradientRotation: progress * 3.14 * 6,
              gradientStops: {
                0.0: const Color(0xFF007BFF),
                1.0: const Color(0xFF39FF14),
              },
            ),
          ),
          if (widget.debugOptions.$2)
            LinearGradientView(
              borderRadius: widget.borderRadius,
              gradientScaleX: 14,
              gradientOffsetX: progress * (1.0 - 1 / 14.0),
              gradientStops: {
                0.0 / 6.0: const Color(0xFFFFB404),
                1.0 / 6.0: const Color(0xFFFFDF80),
                2.0 / 6.0: const Color(0xFFFF7E7F),
                3.0 / 6.0: const Color(0xFFC728FF),
                4.0 / 6.0: const Color(0xFFF872DC),
                5.0 / 6.0: const Color(0xFFFFDF80),
                6.0 / 6.0: const Color(0xFFFFB508),
              },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Opacity(opacity: widget.debugOptions.$3 ? 1 : 0.0, child: widget.icon!),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Opacity(
                    opacity: widget.debugOptions.$4 ? 1 : 0.0,
                    child: LinearGradientText(
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
                      gradientOffsetX: progress * (1.0 - 1 / 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
