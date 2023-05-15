import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PicklistPage extends StatelessWidget {
  const PicklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          DuelingPicklist<BoxFit>(
            labelText: 'Dueling Picklist',
            available: BoxFit.values,
          ),
          DuelingPicklist<BoxFit>(
            labelText: 'Dueling Picklist (selected)',
            available: BoxFit.values,
            selected: <BoxFit>[BoxFit.contain],
          ),
        ],
      ),
    );
  }
}
