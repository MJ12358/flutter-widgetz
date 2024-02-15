import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SliverListPage extends StatefulWidget {
  const SliverListPage({super.key});

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
        const SliverToBoxAdapter(
          child: _Header(text: 'Sliver Builder'),
        ),
        CustomSliverList.builder(
          itemCount: _widgets.length,
          itemBuilder: (_, int index) {
            return ListTile(
              title: _widgets[index],
            );
          },
        ),
        const SliverToBoxAdapter(
          child: _Header(text: 'Sliver Separated'),
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
        const SliverToBoxAdapter(
          child: _Header(text: 'Sliver Reorder'),
        ),
        CustomSliverReorderableList.separated(
          itemCount: _widgets.length,
          itemBuilder: (_, int index) {
            return ListTile(
              key: ValueKey<int>(index),
              title: _widgets[index],
            );
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
          onReorder: (int oldIndex, int newIndex) {
            final Widget w = _widgets.removeAt(oldIndex);
            _widgets.insert(newIndex, w);
            setState(() {});
          },
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: 75,
      padding: const EdgeInsets.all(16.0),
      child: Text(text),
    );
  }
}
