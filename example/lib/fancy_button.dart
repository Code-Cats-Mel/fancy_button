import 'dart:math' as math;

import 'package:flutter/material.dart';

class FancyButton extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final String? titleText;
  final String? subtitleText;
  final VoidCallback onTap;

  const FancyButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.width = 400,
    this.height = 80,
    this.borderWidth = 3,
    this.titleText,
    this.subtitleText,
    required this.onTap,
  });

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with TickerProviderStateMixin {
  late Animation<double> _colorStripAnimation;
  late AnimationController _colorStripAnimationController;

  late AnimationController _textShineController;
  late Animation<Color?> _textShineAnimation;

  late AnimationController _gradientAnimationController;
  late Animation<Color?> _gradientAnimation;

  late AnimationController _iconShineAnimationController;

  final Map<double, Color> colorStripStops = {
    0.0: AppColor.mustard,
    0.06: AppColor.mustard,
    0.24: AppColor.lightOrange,
    0.27: AppColor.lightOrange,
    0.37: AppColor.darkPink,
    0.47: AppColor.lightPink,
    0.57: AppColor.yellow,
    0.59: AppColor.yellow,
    0.71: AppColor.mustard,
    0.72: AppColor.mustard,
    0.82: AppColor.mustard,
    0.85: AppColor.mustard,
    1.0: AppColor.mustard,
  };

  final Map<double, Color> gradientStops = {
    0.0: AppColor.neonOrange,
    0.24: AppColor.brightPink,
    0.34: AppColor.brightPink,
    0.44: AppColor.brightPink,
    0.54: AppColor.brightPink,
    0.64: AppColor.brightPink,
    0.74: AppColor.brightPink,
    0.99: AppColor.brightPink,
    1.0: AppColor.neonOrange,
  };

  @override
  void initState() {
    super.initState();

    _colorStripAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    final curvedAnimation = CurvedAnimation(
      parent: _colorStripAnimationController,
      curve: Curves.easeInOut,
    );
    _colorStripAnimation = Tween<double>(begin: -4 * widget.width, end: 0)
        .animate(curvedAnimation);
    _colorStripAnimationController.forward();
    _colorStripAnimationController.addListener(() {
      if (_colorStripAnimationController.status == AnimationStatus.completed) {
        _colorStripAnimationController.reverse();
      } else if (_colorStripAnimationController.status ==
          AnimationStatus.dismissed) {
        _colorStripAnimationController.forward();
      }
      setState(() {});
    });

    _textShineController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1750));
    _textShineAnimation = ColorTween(
      begin: AppColor.black,
      end: AppColor.white,
    ).animate(_textShineController);
    _textShineController.forward();
    _textShineController.addListener(() {
      if (_textShineController.status == AnimationStatus.completed) {
        _textShineController.reverse();
      } else if (_textShineController.status == AnimationStatus.dismissed) {
        _textShineController.forward();
      }
      setState(() {});
    });

    _gradientAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);
    _gradientAnimation = ColorTween(
      begin: AppColor.neonOrange,
      end: AppColor.brightPink,
    ).animate(_gradientAnimationController);
    _gradientAnimationController.forward();
    _gradientAnimationController.addListener(() {
      if (_gradientAnimationController.status == AnimationStatus.completed) {
        _gradientAnimationController.reverse();
      } else if (_gradientAnimationController.status ==
          AnimationStatus.dismissed) {
        _gradientAnimationController.forward();
      }
      setState(() {});
    });

    _iconShineAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _colorStripAnimationController.dispose();
    _textShineController.dispose();
    _gradientAnimationController.dispose();
    _iconShineAnimationController.dispose();
    _colorStripAnimationController.removeListener(() {});
    _textShineController.removeListener(() {});
    _gradientAnimationController.removeListener(() {});
    _iconShineAnimationController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
          animation: _gradientAnimation,
          builder: (context, child) {
            return Container(
              height: widget.height - 1,
              padding: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                gradient: LinearGradient(
                  colors: [
                    _gradientAnimation.value!,
                    _gradientAnimation.value!,
                  ],
                  stops: const [0.0, 1.0],
                  begin: const Alignment(-1.8, -2),
                  end: const Alignment(2, 2),
                ),
                boxShadow: [
                  _CustomShadow(
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    gradient: LinearGradient(
                      colors: gradientStops.values.toList(),
                      stops: gradientStops.keys.toList(),
                      begin: const Alignment(-1.8, -2),
                      end: const Alignment(2, 2),
                    ),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: widget.height,
                    width: widget.width,
                    child: ClipRRect(
                      borderRadius: widget.borderRadius,
                      child: Stack(
                        children: [
                          Positioned(
                            left: _colorStripAnimation.value,
                            top: 0,
                            child: SizedBox(
                              width: widget.width * 8,
                              height: widget.height,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientStops.values.toList(),
                                    stops: gradientStops.keys.toList(),
                                    begin: const Alignment(-1.0, -2),
                                    end: const Alignment(1.0, 2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: _colorStripAnimation.value,
                            top: 0,
                            child: SizedBox(
                              width: widget.width * 6,
                              height: widget.height,
                              child: Container(
                                height: widget.height - 4,
                                width: widget.width - 4,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: colorStripStops.values.toList(),
                                  stops: colorStripStops.keys.toList(),
                                  begin: const Alignment(-1.0, -2),
                                  end: const Alignment(1.0, 2),
                                )),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const SizedBox(
                                    width: 38,
                                    height: 38,
                                    child: Icon(Icons.diamond_rounded),
                                  ),
                                  CustomPaint(
                                    painter: CircularShinePainter(
                                        _iconShineAnimationController),
                                    child: const SizedBox(
                                      width: 38,
                                      height: 38,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              ShaderMask(
                                shaderCallback: (shader) => LinearGradient(
                                  colors: [
                                    _textShineAnimation.value!,
                                    _textShineAnimation.value!
                                  ],
                                ).createShader(shader),
                                blendMode: BlendMode.srcATop,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (widget.titleText != null)
                                      Text(
                                        widget.titleText!,
                                        // style: heavyItalic20.black,
                                      ),
                                    if (widget.subtitleText != null)
                                      Text(
                                        widget.subtitleText!,
                                        // style: ThemeCreator.heavyItalic14.black,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CircularShinePainter extends CustomPainter {
  final AnimationController animationController;

  CircularShinePainter(this.animationController)
      : super(repaint: animationController);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.22;
    const startAngle = -math.pi / 200;
    final endAngle = math.pi / 9 + (math.pi * 2 * animationController.value);
    final sweepAngle = endAngle - startAngle;
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: endAngle,
      colors: const [
        AppColor.transparent,
        AppColor.white,
      ],
      stops: const [0.0, 1.0],
    );
    final shader =
        gradient.createShader(Rect.fromCircle(center: center, radius: radius));

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 6
      ..blendMode = BlendMode.softLight;

    final path = Path()
      ..addArc(Rect.fromCircle(center: center, radius: radius), startAngle,
          sweepAngle);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircularShinePainter oldDelegate) {
    return animationController != oldDelegate.animationController;
  }
}

class _CustomShadow extends BoxShadow {
  final Gradient gradient;

  const _CustomShadow(
      {required this.gradient,
      super.offset,
      super.blurRadius,
      spreadRadius = 0.0})
      : super(color: Colors.black, spreadRadius: spreadRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..shader = gradient.createShader(const Rect.fromLTWH(0, 0, 300, 200))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    return result;
  }

  @override
  BoxShadow scale(double factor) {
    return _CustomShadow(
      offset: offset * factor,
      gradient: gradient,
      blurRadius: blurRadius * factor,
      spreadRadius: spreadRadius * factor,
    );
  }
}

class AppColor {
  static const Color swatch50 = Color.fromRGBO(144, 19, 254, .1);
  static const Color swatch100 = Color.fromRGBO(144, 19, 254, .10);
  static const Color swatch150 = Color.fromRGBO(144, 19, 254, .15);
  static const Color swatch200 = Color.fromRGBO(144, 19, 254, .3);
  static const Color swatch300 = Color.fromRGBO(144, 19, 254, .4);
  static const Color swatch400 = Color.fromRGBO(144, 19, 254, .5);
  static const Color swatch500 = Color.fromRGBO(144, 19, 254, .6);
  static const Color swatch600 = Color.fromRGBO(144, 19, 254, .7);
  static const Color swatch700 = Color.fromRGBO(144, 19, 254, .8);
  static const Color swatch800 = Color.fromRGBO(144, 19, 254, .9);
  static const Color swatch900 = Color.fromRGBO(144, 19, 254, 1);

  static const Map<int, Color> mainSwatchMap = {
    50: swatch50,
    100: swatch100,
    200: swatch200,
    300: swatch300,
    400: swatch400,
    500: swatch500,
    600: swatch600,
    700: swatch700,
    800: swatch800,
    900: swatch900
  };

  //Primary color is the same as swatch900
  static const MaterialColor mainSwatch =
      MaterialColor(0xFF9013FE, mainSwatchMap);

  static const Color main = swatch900;
  static const Color agletBlue = Color(0xFF438CFF);
  static const Color agletBlueOpacity15 = Color.fromRGBO(67, 140, 255, .15);
  static const Color agletBlueOpacity0 = Color.fromRGBO(67, 140, 255, .0);
  static const Color emerald = Color(0xFF43CEA2);
  static const Color emeraldOpacity15 = Color.fromRGBO(67, 206, 162, .15);
  static const Color emeraldOpacity20 = Color.fromRGBO(67, 206, 162, .2);
  static const Color navy = Color(0xFF185A9D);
  static const Color navyOpacity15 = Color.fromRGBO(24, 90, 157, .15);
  static const Color darkGrey = Color.fromRGBO(74, 74, 74, 1);
  static const Color darkSteelGrey = Color.fromRGBO(43, 43, 43, 1);
  static const Color semiGrey = Color(0xFF545454);
  static const Color brandGrey = Color.fromARGB(255, 88, 88, 88);
  static const Color titleGrey = Color.fromARGB(255, 51, 51, 51);
  static const Color baseSneakerContentGrey = Color.fromARGB(255, 92, 92, 92);
  static const Color irlWebviewAppBarBlack = Color.fromARGB(255, 18, 18, 16);
  static const Color irlWebviewAppBarBlackOpacity =
      Color.fromARGB(255, 81, 79, 71);
  static const Color avatarOnMapBlurredBackground =
      Color.fromRGBO(0, 0, 0, 0.45);

  static const Color veryLightGrey = Color(0xFFF0F0F0);
  static const Color lightGrey = Color(0xFFD8D8D8);
  static const Color grey = Color(0xFF9B9B9B);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color blackW5Opacity = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color blackW10Opacity = Color.fromRGBO(0, 0, 0, 0.10);
  static const Color blackW12Opacity = Color.fromARGB(31, 0, 0, 0);
  static const Color blackW20Opacity = Color.fromARGB(51, 0, 0, 0);
  static const Color blackW25Opacity = Color.fromARGB(64, 0, 0, 0);
  static const Color blackW350pacity = Color.fromARGB(89, 0, 0, 0);
  static const Color blackW4Opacity = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color blackW50Opacity = Color.fromARGB(128, 0, 0, 0);
  static const Color blackW60Opacity = Color.fromARGB(153, 0, 0, 0);
  static const Color blackW65Opacity = Color.fromARGB(165, 0, 0, 0);
  static const Color blackW80Opacity = Color.fromRGBO(0, 0, 0, 0.8);
  static const Color generalIconPurple = Color.fromRGBO(116, 65, 255, 1);
  static const Color shadow = Color(0x1F000000);
  static const Color totalEarningsGrey = Color.fromARGB(255, 77, 77, 77);
  static const Color coolGrey90 = Color.fromARGB(150, 138, 149, 158);
  static const Color brightTurquoise = Color(0xFF08E3C2);
  static const Color warmGrey = Color.fromRGBO(151, 151, 151, 1);
  static const Color negativeRed = Color(0xFFD0021B);
  static const Color positiveGreen = Color(0xFF7ED321);
  static const Color backgroundGrey = Color(0xFFF7F7F7);
  static const Color backgroundGreyW1Opacity = Color(0x1FF7F7F7);

  static const Color transparent = Colors.transparent;
  static const Color whiteW80Opacity = Color.fromARGB(204, 255, 255, 255);
  static const Color whiteW60Opacity = Color.fromARGB(153, 255, 255, 255);
  static const Color whiteW50Opacity = Color.fromARGB(128, 255, 255, 255);
  static const Color whiteW40Opacity = Color.fromARGB(102, 255, 255, 255);
  static const Color whiteW20Opacity = Color.fromARGB(51, 255, 255, 255);
  static const Color whiteW10Opacity = Color.fromARGB(26, 255, 255, 255);
  static const Color whiteW30Opacity = Color.fromARGB(77, 255, 255, 255);
  static const Color whiteW07Opacity = Color.fromARGB(18, 255, 255, 255);
  static const Color onboardingContentGrey = Color.fromARGB(255, 92, 92, 92);
  static const Color onboardingContentGreyLight =
      Color.fromARGB(255, 125, 126, 125);
  static const Color blackW75Opacity = Color.fromARGB(190, 0, 0, 0);
  static const Color transitionAgletLabel = Color.fromARGB(255, 218, 192, 255);
  static const Color transitionAgletLabelGold =
      Color.fromARGB(255, 255, 248, 214);

  static const Color textInputInactiveGrey = Color.fromARGB(255, 196, 196, 196);

  static const Color shimmerGrey = Color.fromARGB(255, 187, 187, 187);

  static const Color profileNoDataGrey = Color.fromARGB(255, 237, 237, 237);
  static const Color greySpacer = Color.fromARGB(255, 216, 216, 216);

  static const Color green = Color.fromRGBO(10, 160, 93, 1);
  static const Color lightGreen = Color.fromRGBO(163, 247, 28, 1);
  static const Color lightGreenShadow = Color.fromRGBO(201, 255, 85, 1);
  static const Color darkOrange = Color.fromRGBO(255, 178, 0, 1);
  static const Color darkestOrange = Color.fromRGBO(255, 140, 23, 1);
  static const Color yellowSpot = Color.fromRGBO(255, 217, 0, 1);
  static const Color yellowSpotOpacity15 = Color.fromRGBO(255, 217, 0, .15);
  static const Color pink = Color.fromRGBO(255, 43, 119, 1);
  static const Color neonPink = Color.fromRGBO(255, 0, 153, 1);
  static const Color pinkOpacity10 = Color.fromRGBO(255, 43, 119, 0.1);
  static const Color pinkOpacity15 = Color.fromRGBO(255, 43, 119, 0.15);
  static const Color pinkOpacity50 = Color.fromRGBO(255, 43, 119, 0.50);
  static const Color goldGradientLight = Color.fromRGBO(255, 234, 123, 1);
  static const Color goldGradientLighter = Color.fromRGBO(231, 204, 117, 1);
  static const Color goldAgletGold = Color.fromRGBO(197, 166, 74, 1);
  static const Color gold = Color.fromRGBO(255, 209, 69, 1);
  static const Color goldGradientDark = Color.fromRGBO(255, 209, 69, 1);
  static const Color goldGradientDarker = Color.fromRGBO(222, 169, 54, 1);
  static const Color goldDarker = Color.fromRGBO(203, 165, 52, 1);
  static const Color goldDarkest = Color.fromRGBO(182, 148, 46, 1);
  static const Color sliderGrey = Color.fromRGBO(164, 164, 164, 1);
  static const Color dotsGrey = Color.fromRGBO(146, 146, 146, 1);
  static const Color slightlyLightGrey = Color.fromRGBO(155, 155, 155, 1);
  static const Color slightlyLightGrey60opacity =
      Color.fromRGBO(155, 155, 155, 0.6);
  static const Color lightBlue = Color.fromRGBO(123, 177, 221, 1);
  static const Color blueSemiTransparentForScanner =
      Color.fromRGBO(67, 140, 255, 0.2);
  static const Color mediumDark = Color.fromRGBO(39, 39, 39, 1);

  static const Color lightestBlueForGradient =
      Color.fromRGBO(67, 140, 255, 0.3);
  static const Color semiBlueForGradient = Color.fromRGBO(67, 140, 255, 0.6);
  static const Color violet = Color.fromRGBO(199, 9, 254, 1);
  static const Color electricViolet = Color.fromRGBO(211, 6, 255, 1);
  static const Color irlPurple = Color.fromRGBO(144, 19, 254, 1);
  static const Color violetDarker = Color.fromRGBO(140, 23, 254, 1);
  static const Color coinPurple = Color.fromRGBO(130, 40, 254, 1);
  static const Color irlButtonPurple = Color.fromRGBO(97, 0, 255, 1);
  static const Color filterPurple = Color.fromRGBO(242, 227, 254, 1);
  static const Color borderGrey = Color.fromRGBO(232, 232, 232, 1);
  static const Color mapCircleRadiusBlue = Color.fromRGBO(67, 140, 255, 0.13);
  static const Color mapCurrentPositionBlue = Color.fromRGBO(36, 150, 249, 1);
  static const Color mapboxAttributionBlue = Color.fromARGB(255, 73, 140, 159);
  static const Color darkIndigo = Color.fromRGBO(54, 6, 95, 1);
  static const Color brightGrey = Color.fromRGBO(235, 235, 235, 1);
  static const Color brightGreen = Color.fromRGBO(126, 211, 33, 1);
  static const Color dullGrey = Color.fromRGBO(135, 135, 135, 1);

  // #### Avatars ####
  static const Color skinTone1 = Color.fromRGBO(234, 191, 162, 1);
  static const Color skinTone2 = Color.fromRGBO(221, 177, 155, 1);
  static const Color skinTone3 = Color.fromRGBO(206, 160, 128, 1);
  static const Color skinTone4 = Color.fromRGBO(170, 129, 101, 1);
  static const Color skinTone5 = Color.fromRGBO(132, 99, 82, 1);
  static const Color skinTone6 = Color.fromRGBO(127, 89, 78, 1);
  static const Color apparelLoadingContainer = Color.fromRGBO(244, 244, 244, 1);
  static const Color overlayGrey = Color.fromRGBO(99, 99, 99, 1);
  static const Color hairColour1 = Color.fromRGBO(65, 67, 71, 1);
  static const Color hairColour2 = Color.fromRGBO(130, 79, 67, 1);
  static const Color hairColour3 = Color.fromRGBO(178, 110, 84, 1);
  static const Color hairColour4 = Color.fromRGBO(216, 130, 104, 1);
  static const Color hairColour5 = Color.fromRGBO(255, 115, 72, 1);
  static const Color hairColour6 = Color.fromRGBO(244, 83, 83, 1);
  static const Color hairColour7 = Color.fromRGBO(226, 191, 147, 1);
  static const Color hairColour8 = Color.fromRGBO(255, 207, 72, 1);
  static const Color hairColour9 = Color.fromRGBO(105, 168, 250, 1);
  static const Color hairColour10 = Color.fromRGBO(107, 242, 177, 1);
  static const Color hairColour11 = Color.fromRGBO(239, 108, 168, 1);
  static const Color hairColour12 = Color.fromRGBO(175, 184, 188, 1);

  static const Color irlGreen = Color.fromRGBO(67, 206, 162, 1);

  static const Color mustard = Color.fromRGBO(255, 180, 4, 1);
  static const Color yellow = Color.fromRGBO(255, 223, 128, 1);
  static const Color lightOrange = Color.fromRGBO(255, 126, 127, 1);
  static const Color darkPink = Color.fromRGBO(199, 40, 255, 1);
  static const Color lightPink = Color.fromRGBO(248, 114, 220, 1);
  static const Color neonOrange = Color.fromRGBO(255, 61, 0, 1);
  static const Color brightPink = Color.fromRGBO(255, 0, 245, 1);
}
