import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DropdownFieldPage extends StatelessWidget {
  const DropdownFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const DropdownField<String>(
            labelText: 'Dropdown One',
            items: <String>['1', '2', '3'],
            onChanged: print,
          ),
          const DropdownField<BoxFit>(
            labelText: 'Dropdown Two',
            items: <BoxFit>[
              BoxFit.contain,
              BoxFit.cover,
              BoxFit.fill,
            ],
            onChanged: print,
            prefixIcon: Icons.gif_outlined,
          ),
          DropdownField<BoxFit>(
            labelText: 'Dropdown Three (Formatted)',
            items: const <BoxFit>[
              BoxFit.contain,
              BoxFit.cover,
              BoxFit.fill,
            ],
            onChanged: print,
            displayStringForItem: (BoxFit v) => v.name,
            prefixIcon: Icons.gif_box,
          ),
          DropdownField<BoxFit>(
            labelText: 'Dropdown Four (Initial Value)',
            items: const <BoxFit>[
              BoxFit.contain,
              BoxFit.cover,
              BoxFit.fill,
            ],
            onChanged: print,
            displayStringForItem: (BoxFit v) => v.name,
            prefixIcon: Icons.select_all,
            value: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}