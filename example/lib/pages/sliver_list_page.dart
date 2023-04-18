import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SliverListPage extends StatefulWidget {
  const SliverListPage({Key? key}) : super(key: key);

  @override
  State<SliverListPage> createState() => _SliverListPageState();
}

class _SliverListPageState extends State<SliverListPage> {
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
            child: const Text('A Builder List!'),
          ),
        ),
        CustomSliverList.builder(
          itemCount: _widgets.length,
          itemBuilder: (_, int index) {
            return ListTile(
              title: _widgets[index],
            );
          },
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: 75,
            child: const Text('A Separated List!'),
          ),
        ),
        CustomSliverList.separated(
          itemCount: _widgets.length,
          itemBuilder: (_, int index) {
            return ListTile(
              title: _widgets[index],
            );
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
        ),
      ],
    );
  }
}
