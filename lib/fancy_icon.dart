library fancy_button;

import 'package:flutter/material.dart';

class FancyIcon extends StatefulWidget {
  const FancyIcon({super.key});

  @override
  State<FancyIcon> createState() => _FancyIconState();
}

class _FancyIconState extends State<FancyIcon> with TickerProviderStateMixin {
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
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFCD981),
        Color(0xFFDF8600),
      ],
    );
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Shimmer(
                slidePercent: (_animation.value < 0.1 || _animation.value > 0.9)
                    ? (_animation.value * 10) % 1.0
                    : 0,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradient,
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
            shaderCallback: (rect) => gradient.createShader(rect),
            blendMode: BlendMode.srcATop,
            child: const Icon(
              Icons.diamond,
              color: Colors.white,
              size: 20,
            ),
          ),
      ],
    );
  }
}

class Shimmer extends StatefulWidget {
  final Widget child;
  final double slidePercent;

  const Shimmer({required this.child, this.slidePercent = 0.0, super.key});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  static const _shimmerGradient = LinearGradient(
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
        return _shimmerGradient.createShader(
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
