import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DateInputPage extends StatelessWidget {
  const DateInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const DateInput(
            labelText: 'Date Input',
            onChanged: print,
          ),
          const DateInput(
            labelText: 'Date Input Error',
            errorText: 'Error',
            showError: true,
            onChanged: print,
          ),
          DateInput(
            labelText: 'Date Input (ISO8601 String)',
            onChanged: print,
            displayStringForDate: (DateTime? v) => v?.toIso8601String() ?? '',
          ),
          DateInput(
            labelText: 'Date Input (Initial Value)',
            onChanged: print,
            value: DateTime.now(),
          ),
          const DateRangeInput(
            labelText: 'Date Range',
            onChanged: print,
          ),
        ],
      ),
    );
  }
}
