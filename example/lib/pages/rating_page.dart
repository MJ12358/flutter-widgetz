import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const RatingBar(
            onChanged: print,
          ),
          const RatingBar(
            onChanged: print,
            color: Colors.purple,
            value: 3.5,
          ),
          RatingBar(
            onChanged: print,
            color: Colors.deepOrange,
            unratedColor: Colors.deepOrange.withAlpha(50),
            max: 10,
            value: 6.5,
            size: 25,
          ),
        ],
      ),
    );
  }
}
