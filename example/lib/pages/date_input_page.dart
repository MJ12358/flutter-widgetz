import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DateInputPage extends StatelessWidget {
  const DateInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const DateInput(
            labelText: 'Date Input 1',
            onChanged: print,
          ),
          DateInput(
            labelText: 'Date Input 2',
            onChanged: print,
            displayStringForDate: (DateTime? v) => v?.toIso8601String() ?? '',
          ),
          DateInput(
            labelText: 'Date Input 3',
            onChanged: print,
            value: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
