import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CounterInputPage extends StatelessWidget {
  const CounterInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CounterInput(
            labelText: 'Counter One',
            onChanged: print,
            value: 5,
          ),
          CounterInput(
            labelText: 'Counter Two',
            onChanged: print,
            value: 1,
            errorText: 'There is an error',
            showError: true,
          ),
          CounterInput(
            labelText: 'Counter Three',
            onChanged: print,
            value: 10,
            decrementIcon: Icons.remove,
            incrementIcon: Icons.add,
          ),
        ],
      ),
    );
  }
}
