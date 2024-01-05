import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DurationFieldPage extends StatelessWidget {
  const DurationFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: CustomOrientationBuilder(
        landscapeBuilder: (_) {
          return const SpacedRow(
            children: <Widget>[
              DurationField(
                labelText: 'Duration Field',
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
              const DurationPicker(
                color: Colors.green,
                snapToMins: 15,
                onChanged: print,
              ),
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.timelapse),
              ),
              const DurationField(
                labelText: 'Duration Field',
                onChanged: print,
              ),
              const DurationField(
                labelText: 'Duration Field (Default Value)',
                value: Duration(minutes: 30, seconds: 15),
                onChanged: print,
              ),
              DurationField(
                labelText: 'Duration Field (formatted)',
                onChanged: print,
                displayStringForDuration: (Duration? d) =>
                    d != null ? '${d.inMinutes} Minutes' : '',
              ),
              const DurationField(
                labelText: 'Duration Field (snapToMins)',
                snapToMins: 5,
                onChanged: print,
              ),
              const DurationField(
                unit: DurationPickerUnit.hour,
                labelText: 'Duration Field (baseunit)',
                onChanged: print,
              ),
            ],
          );
        },
      ),
    );
  }
}
