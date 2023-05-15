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
        children: <Widget>[
          const CustomPlaceholder(
            text: 'Placeholder One (No Image)',
          ),
          CustomPlaceholder.network(
            'https://loremflickr.com/640/360',
          ),
          CustomPlaceholder.network(
            'https://loremflickr.com/640/360',
            text: 'Placeholder Two (Image)',
          ),
          const CustomPlaceholder(
            text: 'Placeholder Three (Icon)',
            child: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
