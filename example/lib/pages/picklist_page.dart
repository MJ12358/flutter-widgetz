import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PicklistPage extends StatelessWidget {
  const PicklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const DuelingPicklist<BoxFit>(
            label: Text('Dueling Picklist'),
            available: BoxFit.values,
          ),
          DuelingPicklist<BoxFit>(
            label: const Text('Dueling Picklist (selected)'),
            available: BoxFit.values,
            selected: const <BoxFit>[BoxFit.contain],
            onSort: (BoxFit a, BoxFit b) => b.name.compareTo(a.name),
          ),
        ],
      ),
    );
  }
}
