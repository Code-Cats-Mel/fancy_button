library fancy_gradient_button;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'line_gradient_view.dart';
import 'fancy_theme.dart';
import 'line_gradient_text.dart';

class FancyButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget title;
  final Widget? subtitle;
  final Widget? icon;
  final double? progress;
  final void Function(double progress)? progressCallback;
  final (bool, bool, bool, bool) debugOptions;

  final BorderRadius borderRadius;

  final FancyButtonTheme theme;

  const FancyButton(
    this.title,
    this.theme, {
    super.key,
    this.onTap,
    this.subtitle,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.progress,
    this.progressCallback,
    this.debugOptions = const (true, true, true, true),
  });

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 10), vsync: this);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

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
              blurRadius: widget.theme.borderRadius,
              spreadRadius: widget.theme.spreadRadius,
              gradientRotation: progress *
                  6.28 *
                  widget.theme.backgroundShadowRotationSpeedFactor,
              gradient: widget.theme.backgroundShadowGradient,
            ),
          ),
          if (widget.debugOptions.$2)
            LinearGradientView(
              borderRadius: widget.borderRadius,
              gradientScaleX: widget.theme.gradientScaleX,
              gradientOffsetX:
                  progress * (1.0 - 1 / widget.theme.gradientScaleX),
              gradient: widget.theme.backgroundGradient,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Opacity(
                      opacity: widget.debugOptions.$3 ? 1 : 0.0,
                      child: widget.icon!),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Opacity(
                    opacity: widget.debugOptions.$4 ? 1 : 0.0,
                    child: LinearGradientText(
                      widget.title,
                      subtitle: widget.subtitle,
                      gradient: widget.theme.textGradient,
                      gradientScaleX: widget.theme.gradientScaleX,
                      gradientOffsetX:
                          progress * (1.0 - 1 / widget.theme.gradientScaleX),
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
