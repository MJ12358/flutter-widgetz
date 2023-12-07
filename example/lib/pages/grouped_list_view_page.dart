import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class GroupedListViewPage extends StatelessWidget {
  const GroupedListViewPage({super.key});

  static const List<Map<String, Object>> _items = <Map<String, Object>>[
    <String, String>{'name': 'John', 'group': 'Team A'},
    <String, String>{'name': 'Will', 'group': 'Team B'},
    <String, String>{'name': 'Beth', 'group': 'Team A'},
    <String, String>{'name': 'Miranda', 'group': 'Team B'},
    <String, String>{'name': 'Mike', 'group': 'Team C'},
    <String, String>{'name': 'Danny', 'group': 'Team C'},
  ];

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Map<String, Object>, String>(
      items: _items,
      itemBuilder: (_, Map<String, Object> item) {
        return ListTile(
          title: Text(item['name']! as String),
        );
      },
      groupBy: (Map<String, Object> item) {
        return item['group']! as String;
      },
      groupHeaderBuilder: (String value) {
        return ListTile(
          title: Text(value),
          tileColor: Colors.black12,
        );
      },
    );
  }
}
