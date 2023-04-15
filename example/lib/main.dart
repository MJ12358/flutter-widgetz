import 'package:flutter/material.dart';
import 'package:flutter_widgetz_example/app.dart';

/// To run the example app, clone/fork the repo!

void main() {
  runApp(const _Main());
}

class _Main extends StatelessWidget {
  const _Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgetz Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}
