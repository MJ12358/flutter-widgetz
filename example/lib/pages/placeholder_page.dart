import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomPlaceholder(
            text: 'Placeholder One (No Image)',
          ),
          CustomPlaceholder(
            text: 'Placeholder Two (Image)',
            networkImage: 'https://loremflickr.com/640/360',
          ),
          CustomPlaceholder(
            text: 'Placeholder Three (Icon)',
            child: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
