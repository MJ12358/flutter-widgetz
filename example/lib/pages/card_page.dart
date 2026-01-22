// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CustomCard.title(
            title: Text('Card (Title)'),
            child: Text(
              'This is a custom card with a title above it.',
            ),
          ),
          CustomCard.title(
            title: const Text('Card (onTap)'),
            onTap: () => print('Card tapped!'),
            child: const Text(
              'This card has an onTap callback.',
            ),
          ),
          CustomCard.title(
            title: Text('Card (Long Title)' * 8),
            child: const Text(
              'This is a custom card with a longer title to demonstrate how the title section adapts to more content.',
            ),
          ),
          CustomCard.title(
            title: const Text('Card (Long Content)'),
            child: Text(
              'This is a custom card with a lot of content. ' *
                  20, // Repeat the string to simulate long content
            ),
          ),
        ],
      ),
    );
  }
}
