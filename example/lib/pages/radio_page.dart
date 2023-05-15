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
          const RadioGroup<String>(
            labelText: 'Radio Group One (String)',
            items: <String>['1', '2', '3'],
            onChanged: print,
          ),
          const RadioGroup<BoxFit>(
            labelText: 'Radio Group Two (Enum)',
            items: <BoxFit>[BoxFit.contain, BoxFit.cover, BoxFit.fill],
            onChanged: print,
            prefixIcon: Icons.gif_box,
            initialValue: BoxFit.contain,
          ),
          RadioGroup<BoxFit>(
            labelText: 'Radio Group Two (Enum with Formatter)',
            items: const <BoxFit>[BoxFit.contain, BoxFit.cover, BoxFit.fill],
            onChanged: print,
            prefixIcon: Icons.account_box,
            displayStringForItem: (BoxFit v) => v.name,
          ),
        ],
      ),
    );
  }
}
