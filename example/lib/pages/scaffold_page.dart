import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Everything here is inside a '
            '"CustomScaffold" via the "MaterialApp".',
          ),
          CustomElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(builder: (_) => const _TestPage()),
            ),
            child: const Text('Push Page'),
          ),
        ],
      ),
    );
  }
}

class _TestPage extends StatelessWidget {
  const _TestPage();

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
