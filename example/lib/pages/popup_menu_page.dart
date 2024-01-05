import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PopupMenuPage extends StatefulWidget {
  const PopupMenuPage({super.key});

  @override
  State<PopupMenuPage> createState() => _PopupMenuPageState();
}

class _PopupMenuPageState extends State<PopupMenuPage> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      child: PopupMenuButton<int>(
        child: Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.primary,
        ),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 1,
              child: Text('Default'),
            ),
            const PopupMenuDivider(),
            const CustomPopupMenuItem<int>(
              value: 2,
              child: Text('Custom'),
            ),
            const PopupMenuDivider(),
            CheckedPopupMenuItem<int>(
              checked: _value == 3,
              value: 3,
              child: const Text('Default Checked'),
            ),
            const PopupMenuDivider(),
            CustomPopupMenuItem<int>.checked(
              checked: _value == 4,
              value: 4,
              child: const Text('Custom Checked'),
            ),
            const PopupMenuDivider(),
            CustomPopupMenuItem<int>.icon(
              icon: Icons.abc,
              value: 5,
              child: const Text('Custom Icon One'),
            ),
            const PopupMenuDivider(),
            CustomPopupMenuItem<int>.icon(
              icon: Icons.yard,
              value: 6,
              child: const Text('Custom Icon Two'),
            ),
          ];
        },
        onSelected: (int value) {
          setState(() {
            _value = value;
          });
        },
      ),
    );
  }
}
