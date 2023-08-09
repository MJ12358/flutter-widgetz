import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ShimmerPage extends StatelessWidget {
  const ShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SpacedColumn(
        children: <Widget>[
          const Text('Banner'),
          Shimmer.banner(),
          const Text('List Tile'),
          Shimmer.listTile(),
          const Text('Title'),
          Shimmer.title(),
        ],
      ),
    );
  }
}
