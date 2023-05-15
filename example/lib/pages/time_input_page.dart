import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class TimeInputPage extends StatelessWidget {
  const TimeInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const TimeInput(
            labelText: 'Time Input',
            onChanged: print,
          ),
          const TimeInput(
            errorText: 'Error',
            labelText: 'Time Input Error',
            onChanged: print,
            showError: true,
          ),
          TimeInput(
            labelText: 'Time Input (Formatted)',
            onChanged: print,
            displayStringForTime: (TimeOfDay? v) => v?.format(context) ?? '',
          ),
          TimeInput(
            labelText: 'Time Input (Initial Value)',
            onChanged: print,
            value: TimeOfDay.now(),
          ),
        ],
      ),
    );
  }
}
