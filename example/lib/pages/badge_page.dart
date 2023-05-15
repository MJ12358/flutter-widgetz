import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          Badge(
            label: Text('Default'),
          ),
          Badge(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
          CustomBadge(
            label: Text('Custom'),
          ),
          CustomBadge.inverse(
            label: Text('Inverse'),
          ),
          CustomBadge.lightest(
            label: Text('Lightest'),
          ),
          CustomBadge.success(
            label: Text('Success'),
          ),
          CustomBadge.warning(
            label: Text('Warning'),
          ),
          CustomBadge.error(
            label: Text('Error'),
          ),
          CustomBadge.error(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
