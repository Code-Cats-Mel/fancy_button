library fancy_button;

import 'package:flutter/material.dart';

class FancyIcon extends StatefulWidget {
  final double? progress;
  final Gradient gradient;
  final Widget icon;

  const FancyIcon(this.icon, this.gradient, {super.key, this.progress});

  @override
  State<FancyIcon> createState() => _FancyIconState();
}

class _FancyIconState extends State<FancyIcon> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    _checkProgress();
  }

  @override
  void didUpdateWidget(FancyIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    _checkProgress();
  }

  void _checkProgress() {
    if (widget.progress != null) {
      _animationController.value = widget.progress!;
    } else if (widget.progress == null && !_animationController.isAnimating) {
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
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Shine(
                slidePercent: (_animationController.value < 0.1 ||
                        _animationController.value > 0.9)
                    ? (_animationController.value * 10) % 1.0
                    : 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: widget.gradient,
                  ),
                ),
              );
            }),
        if (true)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black87,
              ),
            ),
          ),
        if (true)
          ShaderMask(
            shaderCallback: (rect) => widget.gradient.createShader(rect),
            blendMode: BlendMode.srcATop,
            child: widget.icon,
          ),
      ],
    );
  }
}

class Shine extends StatefulWidget {
  final Widget child;
  final double slidePercent;

  const Shine({required this.child, this.slidePercent = 0.0, super.key});

  @override
  State<Shine> createState() => _ShineState();
}

class _ShineState extends State<Shine> {
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  static const _shineGradient = LinearGradient(
    colors: [
      Color(0x00EBEBF4),
      Color(0xFFF4F4F4),
      Color(0x00EBEBF4),
    ],
    stops: [
      0.4,
      0.5,
      0.6,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shineGradient.createShader(
          Rect.fromLTWH(
            (widget.slidePercent * 1.2 - 0.6) * size.width,
            (widget.slidePercent * 1.2 - 0.6) * size.height,
            size.width,
            size.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}
