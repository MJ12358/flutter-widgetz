// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isSaving = false;

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
          SaveButton(
            onPressed: _onSaveButtonPressed,
            isSaving: _isSaving,
          ),
          Button(
            color: Colors.black,
            onPressed: () => print('button'),
            child: const Text('Button'),
          ),
          Button.brand(
            onPressed: () => print('brand'),
            child: const Text('Brand'),
          ),
          Button.destructive(
            onPressed: () => print('destructive'),
            child: const Text('Destructive'),
          ),
          Button.inverse(
            onPressed: () => print('inverse'),
            child: const Text('Inverse'),
          ),
          Button.neutral(
            onPressed: () => print('neutral'),
            child: const Text('Neutral'),
          ),
          Button.outline(
            onPressed: () => print('outline1'),
            child: const Text('Outline One'),
          ),
          Button.outline(
            color: Colors.purple,
            onPressed: () => print('outline2'),
            child: const Text('Outline Two'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Button.success(
              onPressed: () => print('success'),
              child: const Text('Success'),
            ),
          ),
        ],
      ),
    );
  }

  /// This is used to simulate a saving event.
  Future<void> _onSaveButtonPressed() async {
    setState(() {
      _isSaving = !_isSaving;
    });
    await Future<void>.delayed(const Duration(seconds: 3));
    setState(() {
      _isSaving = !_isSaving;
    });
  }
}
