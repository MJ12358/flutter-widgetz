import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DividerPage extends StatelessWidget {
  const DividerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CustomDivider(
            child: Text('Divider One'),
          ),
          const CustomDivider(
            thickness: 4,
            child: Text('Divider 2'),
          ),
          CustomDivider(
            thickness: 4,
            color: Theme.of(context).primaryColor,
            child: const Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
