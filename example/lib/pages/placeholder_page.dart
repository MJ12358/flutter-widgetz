import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        spacer: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        children: <Widget>[
          const CustomPlaceholder(
            text: 'Placeholder One (No Image)',
          ),
          CustomPlaceholder.asset(
            'asset',
            text: 'Placeholder Two (Asset)',
          ),
          CustomPlaceholder.network(
            'https://placehold.co/400/png',
            text: 'Placeholder Three (Network)',
          ),
          const CustomPlaceholder(
            text: 'Placeholder Four (Icon)',
            child: Icon(Icons.abc),
          ),
          CustomPlaceholder.flashlight(
            text: 'Placeholder Five (Flashlight)',
          ),
          CustomPlaceholder.flashlight(
            text: 'Placeholder Five (Flashlight with color)',
            color: Colors.pink,
          ),
        ],
      ),
    );
  }
}
