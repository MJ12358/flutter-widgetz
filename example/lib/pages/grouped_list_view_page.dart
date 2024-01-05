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
      groupHeaderBuilder: (String value) {
        return ListTile(
          title: Text(value),
          tileColor: Colors.black12,
        );
      },
    );
  }
}
