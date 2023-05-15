// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final List<Widget> _widgets = <Widget>[];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 25; i++) {
      _widgets.add(
        ListTile(
          key: ValueKey<String>('$i-item'),
          title: Text(
            i.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomReorderableListView.separated(
      itemCount: _widgets.length,
      itemBuilder: (BuildContext context, int index) {
        return _widgets[index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(key: ValueKey<String>('$index-divider'));
      },
      onReorder: (int oldIndex, int newIndex) {
        print(oldIndex);
        print(newIndex);
      },
    );
  }
}
