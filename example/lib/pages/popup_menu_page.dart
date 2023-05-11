import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class PopupMenuPage extends StatefulWidget {
  const PopupMenuPage({Key? key}) : super(key: key);

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
          color: Theme.of(context).primaryColor,
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
              text: 'Custom Checked',
              value: 4,
            ),
            const PopupMenuDivider(),
            CustomPopupMenuItem<int>.icon(
              text: 'Custom Icon One',
              icon: Icons.abc,
              value: 5,
            ),
            const PopupMenuDivider(),
            CustomPopupMenuItem<int>.icon(
              text: 'Custom Icon Two',
              icon: Icons.yard,
              value: 6,
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
