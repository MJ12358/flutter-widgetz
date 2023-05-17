import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class TimeFieldPage extends StatelessWidget {
  const TimeFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const TimeField(
            labelText: 'Time Input',
            onChanged: print,
          ),
          const TimeField(
            errorText: 'Error',
            labelText: 'Time Input Error',
            onChanged: print,
            hasError: true,
          ),
          TimeField(
            labelText: 'Time Input (Formatted)',
            onChanged: print,
            displayStringForTime: (TimeOfDay? v) => v?.format(context) ?? '',
          ),
          TimeField(
            labelText: 'Time Input (Initial Value)',
            onChanged: print,
            value: TimeOfDay.now(),
          ),
        ],
      ),
    );
  }
}
