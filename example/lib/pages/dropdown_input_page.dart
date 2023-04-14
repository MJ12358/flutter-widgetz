import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DropdownInputPage extends StatelessWidget {
  const DropdownInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const DropdownInput<String>(
            labelText: 'Dropdown One',
            items: <String>['1', '2', '3'],
            onChanged: print,
          ),
          DropdownInput<BoxFit>(
            labelText: 'Dropdown Two',
            items: const <BoxFit>[
              BoxFit.contain,
              BoxFit.cover,
              BoxFit.fill,
            ],
            onChanged: print,
            displayStringForItem: (BoxFit v) => v.name,
            prefixIcon: Icons.gif_box,
          ),
          DropdownInput<BoxFit>(
            labelText: 'Dropdown Three',
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
