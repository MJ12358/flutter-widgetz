// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          Alert(
            child: Text('Default'),
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
            icon: Icons.abc,
            child: Text('Custom'),
          ),
        ],
      ),
    );
  }
}
