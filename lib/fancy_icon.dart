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
    final gradientStops = {
      0.0: const Color(0xFFDF8600),
      0.5: const Color(0xFFFCD981),
      1.0: const Color(0xFFDF8600),
    };
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFCD981),
        Color(0xFFDF8600),
      ],
    );
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
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
