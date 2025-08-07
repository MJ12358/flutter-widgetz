import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class TimeFieldPage extends StatelessWidget {
  const TimeFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: CustomOrientationBuilder(
        landscapeBuilder: (_) {
          return const SpacedRow(
            children: <Widget>[
              TimeField(
                labelText: 'Time Field',
                onChanged: print,
              ),
              CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.timelapse),
              ),
            ],
          );
        },
        portraitBuilder: (_) {
          return SpacedColumn(
            children: <Widget>[
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.timelapse),
              ),
              const TimeField(
                labelText: 'Time Field',
                onChanged: print,
              ),
              const TimeField(
                errorText: 'Error',
                labelText: 'Time Field Error',
                onChanged: print,
                hasError: true,
              ),
              TimeField(
                labelText: 'Time Field (Formatted)',
                onChanged: print,
                displayStringForTime: (TimeOfDay? v) =>
                    v?.format(context) ?? '',
              ),
              const TimeField(
                labelText: 'Time Field (24 Hour Format)',
                use24HourFormat: true,
                onChanged: print,
              ),
              const TimeField(
                labelText: 'Time Field (Dial Only)',
                entryMode: TimePickerEntryMode.dialOnly,
                onChanged: print,
              ),
              const TimeField(
                labelText: 'Time Field (Input Only)',
                entryMode: TimePickerEntryMode.inputOnly,
                onChanged: print,
              ),
              TimeField(
                labelText: 'Time Field (Initial Value)',
                onChanged: print,
                value: TimeOfDay.now(),
              ),
            ],
          );
        },
      ),
    );
  }
}
