import 'package:flutter/material.dart';
import 'package:flutter_extensionz/flutter_extensionz.dart';
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

    for (int i = 0; i < 25; i++) {
      _widgets.add(
        CustomListTile.dismissible(
          key: ValueKey<int>(i),
          uniqueKey: ValueKey<int>(i),
          onDismissed: () {
            _widgets.removeAt(i);
            setState(() {});
          },
          confirmDismiss: () =>
              context.showAlertDialog(const Text('Are you sure?')),
          leading: Text(i.toString()),
          title: Text(i.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomReorderableListView.separated(
        itemCount: _widgets.length,
        itemBuilder: (BuildContext context, int index) {
          return _widgets[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(key: ValueKey<String>('$index-divider'));
        },
        onReorder: (int oldIndex, int newIndex) {
          final Widget w = _widgets.removeAt(oldIndex);
          _widgets.insert(newIndex, w);
          setState(() {});
        },
      ),
    );
  }
}
