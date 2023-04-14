import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute<dynamic>(builder: (_) => const _TestPage()),
      ),
      text: 'Tap to push a page',
    );
  }
}

class _TestPage extends StatelessWidget {
  const _TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: const Center(
        child: Text('Now pop this page!'),
      ),
    );
  }
}
