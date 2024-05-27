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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _progress = 0;
  bool autoPlay = true;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                  height: 60,
                  child: FancyButton(
                    'INCREMENT',
                    icon: SizedBox(
                      width: 37,
                      height: 37,
                      child: FancyIcon(
                        progress: autoPlay ? null : _progress,
                      ),
                    ),
                    subtitleText: 'Increment the counter',
                    onTap: _incrementCounter,
                    progress: autoPlay ? null : _progress,
                    progressCallback: (progress) {
                      if (autoPlay) {
                        setState(() {
                          _progress = progress;
                        });
                      }
                    },
                  )),
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
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
