// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CustomElevatedButton(
            child: const Text('Default'),
            onPressed: () => _showDefaultDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Custom'),
            onPressed: () => _showCustomDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Custom Icon'),
            onPressed: () => _showCustomIconDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Custom Checked'),
            onPressed: () => _showCustomCheckedDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Custom All'),
            onPressed: () => _showCustomAllDialog(context),
          ),
        ],
      ),
    );
  }

  void _showDefaultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: const Text('One'),
              onPressed: () {},
            ),
            SimpleDialogOption(
              child: const Text('Two'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            CustomSimpleDialogOption(
              child: const Text('One'),
              onPressed: () {},
            ),
            CustomSimpleDialogOption(
              child: const Text('Two'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  void _showCustomIconDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.abc),
              onPressed: () {},
              child: const Text('One'),
            ),
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.yard),
              onPressed: () {},
              child: const Text('Two'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomCheckedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            CustomSimpleDialogOption.checked(
              checked: false,
              onPressed: () {},
              child: const Text('One'),
            ),
            CustomSimpleDialogOption.checked(
              child: const Text('Two'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  void _showCustomAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            CustomSimpleDialogOption(
              child: const Text('Custom'),
              onPressed: () {},
            ),
            CustomSimpleDialogOption.checked(
              checked: false,
              onPressed: () {},
              child: const Text('Checked false'),
            ),
            CustomSimpleDialogOption.checked(
              child: const Text('Checked true'),
              onPressed: () {},
            ),
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.abc),
              onPressed: () {},
              child: const Text('Icon One'),
            ),
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.yard),
              onPressed: () {},
              child: const Text('Icon Two'),
            ),
            CustomSimpleDialogOption.tile(
              child: const Text('Tile one'),
              onPressed: () => print('tile one'),
            ),
          ],
        );
      },
    );
  }
}
