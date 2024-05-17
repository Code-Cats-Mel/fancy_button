import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'box_decoration_re.dart';

class GradientBackgroundView extends StatefulWidget {
  final List<Color> colors;
  final List<double> stops;

  final BorderRadius borderRadius;

  /// The standard deviation of the Gaussian to convolve with the shadow's shape.
  final double blurRadius;

  /// The amount the box should be inflated prior to applying the blur.
  final double spreadRadius;

  GradientBackgroundView(
    Map<double, Color> gradientStops, {
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.blurRadius = 5.0,
    this.spreadRadius = 0.0,
  })  : stops = gradientStops.keys.toList(),
        colors = gradientStops.values.toList();

  @override
  State<GradientBackgroundView> createState() => _GradientBackgroundViewState();
}

class _GradientBackgroundViewState extends State<GradientBackgroundView>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    _animation =
        Tween<double>(begin: 0, end: math.pi * 2).animate(CurvedAnimation(
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(_animation.value),
          ),
          boxShadow: [
            GradientBoxShadow(
              blurRadius: widget.blurRadius,
              spreadRadius: widget.spreadRadius,
              gradient: LinearGradient(
                colors: widget.colors,
                stops: widget.stops,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(_animation.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
