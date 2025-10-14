import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class GroupedListViewPage extends StatelessWidget {
  const GroupedListViewPage({super.key});

  static const List<Map<String, String>> _items = <Map<String, String>>[
    <String, String>{'name': 'John', 'group': 'Team A'},
    <String, String>{'name': 'Will', 'group': 'Team B'},
    <String, String>{'name': 'Beth', 'group': 'Team A'},
    <String, String>{'name': 'Miranda', 'group': 'Team B'},
    <String, String>{'name': 'Mike', 'group': 'Team C'},
    <String, String>{'name': 'Danny', 'group': 'Team C'},
    <String, String>{'name': 'Dave', 'group': 'Team C'},
    <String, String>{'name': 'Alice', 'group': 'Team A'},
    <String, String>{'name': 'Bob', 'group': 'Team B'},
    <String, String>{'name': 'Charlie', 'group': 'Team A'},
    <String, String>{'name': 'Eve', 'group': 'Team B'},
    <String, String>{'name': 'Frank', 'group': 'Team C'},
    <String, String>{'name': 'Grace', 'group': 'Team A'},
    <String, String>{'name': 'Hank', 'group': 'Team B'},
    <String, String>{'name': 'Ivy', 'group': 'Team B'},
    <String, String>{'name': 'Jack', 'group': 'Team B'},
  ];

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Map<String, String>, String>(
      items: _items,
      itemBuilder: (_, Map<String, String> item) {
        return CustomListTile(
          title: Text(item['name']!),
          leading: Text(item['name']![0]),
        );
      },
      groupBy: (Map<String, String> item) {
        return item['group']!;
      },
      groupHeaderBuilder: (_, String value, List<Map<String, String>> items) {
        return ListTile(
          title: Text('$value (${items.length})'),
          tileColor: Colors.black12,
        );
      },
      separatorBuilder: (_, __) {
        return const Divider();
      },
    );
  }
}
