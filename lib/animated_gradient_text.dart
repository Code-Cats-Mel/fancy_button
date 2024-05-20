import 'package:flutter/material.dart';

import 'box_decoration_re.dart';

class AnimatedGradientText extends StatefulWidget {
  final List<Color> colors;
  final List<double> stops;
  final double colorsRepeatNumber;

  final BorderRadius borderRadius;

  /// The standard deviation of the Gaussian to convolve with the shadow's shape.
  final double blurRadius;

  /// The amount the box should be inflated prior to applying the blur.
  final double spreadRadius;

  AnimatedGradientText(
    Map<double, Color> gradientStops, {
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.colorsRepeatNumber = 3.0,
    this.blurRadius = 5.0,
    this.spreadRadius = 0.0,
  })  : stops = gradientStops.keys.toList(),
        colors = gradientStops.values.toList();

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
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

    _animationController.forward();

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Container(
        decoration: BoxDecorationRe(
          borderRadius: widget.borderRadius,
          color: Colors.transparent,
          gradient: LinearGradient(
            colors: widget.colors,
            stops: widget.stops,
            transform: GradientRotation(_animation.value),
          ),
          boxShadow: [
            GradientBoxShadow(
              blurRadius: widget.blurRadius,
              spreadRadius: widget.spreadRadius,
              scaleX: widget.colorsRepeatNumber,
              gradient: LinearGradient(
                colors: widget.colors,
                stops: widget.stops,
                // transform: GradientOffX(0),
                transform: GradientOffX(
                    _animation.value * (1.0 - 1 / widget.colorsRepeatNumber)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientOffX extends GradientTransform {
  final double offX;

  const GradientOffX(this.offX);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(-bounds.width * offX, 0, 0);
  }
}
