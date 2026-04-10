import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SegmentedSwitchPage extends StatelessWidget {
  const SegmentedSwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: <Widget>[
        const Text('Two Options'),
        const SegmentedSwitch<bool>(
          options: <bool>[true, false],
          value: true,
          onChanged: print,
        ),
        const Text('Three Options'),
        const SegmentedSwitch<String>(
          options: <String>['One', 'Two', 'Three'],
          value: 'One',
          onChanged: print,
        ),
        const Text('Enum Options'),
        const SegmentedSwitch<BoxFit>(
          options: BoxFit.values,
          value: BoxFit.cover,
          onChanged: print,
        ),
        const Text('Enum Options with Formatter'),
        SegmentedSwitch<BoxFit>(
          options: BoxFit.values,
          value: BoxFit.cover,
          displayStringForOption: (BoxFit v) => v.name,
          onChanged: print,
        ),
      ],
    );
  }
}
