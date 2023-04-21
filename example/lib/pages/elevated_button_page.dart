// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ElevatedButtonPage extends StatelessWidget {
  const ElevatedButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CustomElevatedButton(
            onPressed: () => print('button one pressed'),
            text: 'Button One',
          ),
          CustomElevatedButton(
            onPressed: () => print('button two pressed'),
            text: 'Button Two',
          ),
          CustomElevatedButton(
            onPressed: () => print('button three pressed'),
            text: 'Button Three',
            color: Colors.yellow,
          ),
          CustomElevatedButton(
            onPressed: () => print('button four pressed'),
            text: 'Button Four',
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          CustomElevatedButton(
            onPressed: () => print('button five pressed'),
            text: 'Button Five',
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
    );
  }
}
