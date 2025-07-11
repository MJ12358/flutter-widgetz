// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      // TODO: This is a good example of how "filtered" does/does not
      child: SpacedColumn.filtered(
        children: const <Widget>[
          Alert(
            child: Text('Default'),
          ),
          Alert(
            child: Text(
              'This is a long alert message that should wrap to the next line.',
            ),
          ),
          Alert.info(
            child: Text('Info'),
          ),
          Alert.error(
            child: Text('Error'),
          ),
          Alert.offline(
            child: Text('Offline'),
          ),
          Alert.warning(
            child: Text('Warning'),
          ),
          Alert(
            color: Colors.yellow,
            icon: Icon(Icons.abc),
            child: Text('Custom'),
          ),
        ],
      ),
    );
  }
}
