import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ProgressIndicatorPage extends StatelessWidget {
  const ProgressIndicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CustomDivider(child: Text('Circular')),
          CustomProgressIndicator.circular(),
          const CustomDivider(child: Text('Linear')),
          CustomProgressIndicator.linear(),
          const CustomDivider(child: Text('Refresh')),
          CustomProgressIndicator.refresh(),
          const CustomDivider(child: Text('Percent Circular')),
          PercentIndicator.circular(
            value: 50,
          ),
          PercentIndicator.circular(
            height: 100,
            value: 75,
          ),
          const CustomDivider(child: Text('Percent Linear')),
          PercentIndicator.linear(
            value: 50,
          ),
          PercentIndicator.linear(
            height: 25,
            value: .75,
          ),
        ],
      ),
    );
  }
}
