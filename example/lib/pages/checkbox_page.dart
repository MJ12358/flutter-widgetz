import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CheckboxPage extends StatelessWidget {
  const CheckboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: CustomOrientationBuilder(
        landscapeBuilder: (_) {
          return const SpacedRow(
            children: <Widget>[
              CheckboxField(
                labelText: 'Checkbox Field One',
                onChanged: print,
                value: true,
              ),
              CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.gif_box),
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
              const CheckboxGroup<String>(
                labelText: 'Checkbox Group',
                items: <String>['1', '2', '3'],
                onChanged: print,
                initialValues: <String>['1', '2'],
                prefixIcon: Icon(Icons.abc),
              ),
              const CheckboxGroup<BoxFit>(
                labelText: 'Checkbox Group Two (Enum)',
                items: BoxFit.values,
                onChanged: print,
                initialValues: <BoxFit>[BoxFit.cover],
              ),
              CheckboxGroup<BoxFit>(
                labelText: 'Checkbox Group Three (Enum with Formatter)',
                items: BoxFit.values,
                onChanged: print,
                displayStringForItem: (BoxFit v) => v.name,
                initialValues: const <BoxFit>[BoxFit.cover],
              ),
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.check_box),
              ),
              const CheckboxField(
                labelText: 'Checkbox Field',
                onChanged: print,
                value: true,
              ),
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.abc),
                textInputAction: TextInputAction.next,
                value: 'Testing',
              ),
              const CheckboxField(
                labelText: 'Checkbox Field',
                onChanged: print,
                value: false,
              ),
            ],
          );
        },
      ),
    );
  }
}
