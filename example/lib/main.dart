import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

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
      home: const _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Hello World!'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (_) {},
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: CustomBody(
        padding: const EdgeInsets.all(20),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const CustomPlaceholder(
              text: 'Hi There',
            ),
            const RatingBar(
              onChanged: print,
              value: 3.5,
            ),
            CustomElevatedButton(
              onPressed: () {},
              text: 'A Button',
            ),
          ],
        ),
      ),
    );
  }
}
