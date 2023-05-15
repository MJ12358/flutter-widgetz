import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SliverGridPage extends StatefulWidget {
  const SliverGridPage({super.key});

  @override
  State<SliverGridPage> createState() => _SliverGridPageState();
}

class _SliverGridPageState extends State<SliverGridPage> {
  final List<Widget> _widgets = <Widget>[];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 25; i++) {
      _widgets.add(
        Text(i.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: 75,
            padding: const EdgeInsets.all(16.0),
            child: const Text('Sliver Builder'),
          ),
        ),
        CustomSliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 8.0,
            maxCrossAxisExtent: 100.0,
            mainAxisSpacing: 8.0,
          ),
          padding: const EdgeInsets.all(8.0),
          itemCount: _widgets.length,
          itemBuilder: (_, int index) {
            return GridTile(
              child: _widgets[index],
            );
          },
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: 75,
            padding: const EdgeInsets.all(16.0),
            child: const Text('Sliver Count'),
          ),
        ),
        CustomSliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          padding: const EdgeInsets.all(8.0),
          children: const <Widget>[
            GridTile(
              child: Text('Count 1'),
            ),
            GridTile(
              child: Text('Count 2'),
            ),
          ],
        ),
      ],
    );
  }
}
