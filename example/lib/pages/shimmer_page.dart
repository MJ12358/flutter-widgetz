import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ShimmerPage extends StatelessWidget {
  const ShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const Text('Banner'),
          Shimmer.banner(),
          const Text('List Tile'),
          Shimmer.listTile(),
          const Text('Title'),
          Shimmer.title(),
          const Text('Banner (colored)'),
          Shimmer.banner(
            backgroundColor: Colors.pink,
            borderRadius: 16.0,
          ),
          const Text('ListTile (colored)'),
          Shimmer.listTile(
            backgroundColor: Colors.pink,
            borderRadius: 16.0,
          ),
          const Text('Title (colored)'),
          Shimmer.title(
            backgroundColor: Colors.pink,
            borderRadius: 16.0,
          ),
          Shimmer(
            backgroundColor: Colors.black,
            child: Column(
              children: <Widget>[
                const Text('Dude Sweet'),
                const SizedBox(height: 8.0),
                Container(
                  color: Colors.black,
                  height: 12,
                  width: double.infinity,
                ),
                const SizedBox(height: 8.0),
                Container(
                  color: Colors.green,
                  height: 24,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
