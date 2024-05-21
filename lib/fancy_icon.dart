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
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFCD981),
            Color(0xFFDF8600),
          ],
        ),
      ),
      child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            backgroundBlendMode: BlendMode.srcATop,
          ),
          child: const Icon(
            Icons.star,
            color: Colors.white,
            size: 24,
          )),
    );
  }
}
