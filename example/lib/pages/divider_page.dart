import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DividerPage extends StatelessWidget {
  const DividerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn.filtered(
        spacer: const SizedBox(height: 50),
        children: <Widget>[
          const CustomDivider(
            child: Text('Divider One'),
          ),
          const CustomDivider(
            thickness: 4.0,
            child: Text('Divider Two'),
          ),
          const SizedBox.shrink(),
          const SizedBox.shrink(),
          CustomDivider(
            thickness: 4.0,
            color: theme.colorScheme.primary,
            child: const Icon(Icons.abc),
          ),
          CustomDivider(
            thickness: 10.0,
            color: theme.colorScheme.secondary,
            child: const Icon(Icons.textsms_sharp),
          ),
          const CustomDivider(
            child: Column(
              children: <Widget>[
                Text('Title'),
                Row(
                  children: <Widget>[
                    Text('One'),
                    Text('Two'),
                  ],
                ),
              ],
            ),
          ),
          const _TestWidget(),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _TestWidget extends StatelessWidget {
  const _TestWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
