import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class RadioPage extends StatelessWidget {
  const RadioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CustomTextField(
            labelText: 'Text Field (for reference)',
            prefixIcon: Icon(Icons.timelapse),
          ),
          const RadioFieldGroup<String>(
            labelText: 'Radio Group',
            items: <String>['1', '2', '3'],
            onChanged: print,
            prefixIcon: Icon(Icons.gif_box),
          ),
          const RadioFieldGroup<BoxFit>(
            labelText: 'Radio Group Two (Enum)',
            items: BoxFit.values,
            onChanged: print,
            initialValue: BoxFit.contain,
          ),
          RadioFieldGroup<BoxFit>(
            labelText: 'Radio Group Two (Enum with Formatter)',
            items: BoxFit.values,
            onChanged: print,
            prefixIcon: const Icon(Icons.account_box),
            displayStringForItem: (BoxFit v) => v.name,
          ),
        ],
      ),
    );
  }
}
