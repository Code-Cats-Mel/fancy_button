import 'package:fancy_button/fancy_button.dart';
import 'package:fancy_button/fancy_icon.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fancy button Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  double _progress = 0;
  bool autoPlay = true;
  bool expanded = false;

  static const layerHeight = 50;

  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          final offsetY = _animationController.value;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 24),
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Stack(
                  children: [
                    MyButton(
                      _progress,
                      autoPlay,
                      debugOptions: (true, false, false, false),
                      offsetY: offsetY * layerHeight * 2,
                      transformY: offsetY,
                    ),
                    MyButton(
                      _progress,
                      autoPlay,
                      debugOptions: (false, true, false, false),
                      offsetY: offsetY * layerHeight * 1,
                      transformY: offsetY,
                    ),
                    MyButton(
                      _progress,
                      autoPlay,
                      onTap: _incrementCounter,
                      progressCallback: (progress) {
                        if (autoPlay) {
                          setState(() {
                            _progress = progress;
                          });
                        }
                      },
                      debugOptions: (false, false, true, true),
                      transformY: offsetY,
                    ),
                  ],
                ),
                Slider(
                  value: _progress,
                  onChanged: (value) {
                    setState(() {
                      _progress = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.pause,
                        color: !autoPlay ? Colors.grey : Colors.black87,
                      ),
                      onPressed: () {
                        setState(() {
                          autoPlay = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.play_arrow,
                        color: autoPlay ? Colors.grey : Colors.black87,
                      ),
                      onPressed: () {
                        setState(() {
                          setState(() {
                            autoPlay = true;
                          });
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        expanded
                            ? Icons.keyboard_double_arrow_down
                            : Icons.keyboard_double_arrow_up,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        setState(() {
                          expanded = !expanded;
                          if (expanded) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        });
                      },
                    ),
                  ],
                ),
                Slider(
                  value: offsetY,
                  onChanged: (value) {
                    setState(() {
                      _animationController.value = value;
                    });
                  },
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton(
    this.progress,
    this.autoPlay, {
    this.onTap,
    this.progressCallback,
    this.debugOptions = const (true, true, true, true),
    super.key,
    this.offsetY = 0.0,
    this.transformY = 0.0,
  });

  final VoidCallback? onTap;
  final double progress;
  final double offsetY;
  final double transformY;
  final bool autoPlay;
  final void Function(double progress)? progressCallback;
  final (bool, bool, bool, bool) debugOptions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24 + offsetY, 24, 24),
      child: SizedBox(
          height: 60,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-transformY),
            alignment: FractionalOffset.center,
            child: FancyButton(
              'INCREMENT',
              icon: SizedBox(
                width: 37,
                height: 37,
                child: FancyIcon(
                  progress: autoPlay ? null : progress,
                ),
              ),
              subtitleText: 'Increment the counter',
              onTap: onTap,
              progress: autoPlay ? null : progress,
              progressCallback: progressCallback,
              debugOptions: debugOptions,
            ),
          )),
    );
  }
}
