import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CheckboxPage extends StatelessWidget {
  const CheckboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CheckboxGroup<String>(
            labelText: 'Checkbox Group One (String)',
            items: <String>['1', '2', '3'],
            onChanged: print,
            initialValues: <String>['1', '2'],
          ),
          const CheckboxGroup<BoxFit>(
            labelText: 'Checkbox Groupt Two (Enum)',
            items: <BoxFit>[
              BoxFit.contain,
              BoxFit.cover,
              BoxFit.fill,
            ],
            onChanged: print,
            initialValues: <BoxFit>[BoxFit.cover],
          ),
          CheckboxGroup<BoxFit>(
            labelText: 'Checkbox Groupt Three (Enum with Formatter)',
            items: const <BoxFit>[
              BoxFit.contain,
              BoxFit.cover,
              BoxFit.fill,
            ],
            onChanged: print,
            displayStringForItem: (BoxFit v) => v.name,
            initialValues: const <BoxFit>[BoxFit.cover],
          ),
          const CheckboxInput(
            labelText: 'Checkbox Input',
            onChanged: print,
            value: true,
          ),
          const CheckboxInput(
            labelText: 'Checkbox Input',
            onChanged: print,
            value: false,
          ),
        ],
      ),
    );
  }
}
