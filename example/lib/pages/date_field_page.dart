import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DateFieldPage extends StatelessWidget {
  const DateFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const DateField(
            labelText: 'Date Field',
            onChanged: print,
          ),
          const DateField(
            labelText: 'Date Field Error',
            errorText: 'Error',
            hasError: true,
            onChanged: print,
          ),
          DateField(
            labelText: 'Date Field (ISO8601 String)',
            onChanged: print,
            displayStringForDate: (DateTime? v) => v?.toIso8601String() ?? '',
          ),
          DateField(
            labelText: 'Date Field (Initial Value)',
            onChanged: print,
            value: DateTime.now(),
          ),
          const DateRangeField(
            labelText: 'Date Range',
            onChanged: print,
          ),
        ],
      ),
    );
  }
}