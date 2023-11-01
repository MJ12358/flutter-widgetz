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
          CustomDivider(
            child: Text('Flutter Defaults'),
          ),
          Badge(
            label: Text('Default'),
          ),
          Badge(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
          CustomDivider(
            child: Text('Custom'),
          ),
          CustomBadge(
            label: Text('Default'),
          ),
          CustomBadge(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
          CustomBadge.inverse(
            label: Text('Inverse'),
          ),
          CustomBadge.inverse(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
          CustomBadge.lightest(
            label: Text('Lightest'),
          ),
          CustomBadge.lightest(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
          CustomBadge.success(
            label: Text('Success'),
          ),
          CustomBadge.success(
            label: Text('5'),
            child: Icon(Icons.abc),
          ),
          CustomBadge.warning(
            label: Text('Warning'),
          ),
          CustomBadge.warning(
            label: Text('5'),
            child: Icon(Icons.abc),
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
