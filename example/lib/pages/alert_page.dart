import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const Alert(
            child: Text('Default'),
          ),
          Alert.error(
            child: const Text('Error'),
          ),
          Alert.offline(
            child: const Text('Offline'),
          ),
          Alert.warning(
            child: const Text('Warning'),
          ),
        ],
      ),
    );
  }
}
