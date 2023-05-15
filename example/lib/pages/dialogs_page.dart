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
            text: 'Default',
            onPressed: () => _showDefaultDialog(context),
          ),
          CustomElevatedButton(
            text: 'Custom',
            onPressed: () => _showCustomDialog(context),
          ),
          CustomElevatedButton(
            text: 'Custom Icon',
            onPressed: () => _showCustomIconDialog(context),
          ),
          CustomElevatedButton(
            text: 'Custom Checked',
            onPressed: () => _showCustomCheckedDialog(context),
          ),
          CustomElevatedButton(
            text: 'Custom All',
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
              text: 'One',
              icon: Icons.abc,
              onPressed: () {},
            ),
            CustomSimpleDialogOption.icon(
              text: 'Two',
              icon: Icons.yard,
              onPressed: () {},
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
              text: 'One',
              checked: false,
              onPressed: () {},
            ),
            CustomSimpleDialogOption.checked(
              text: 'Two',
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
              text: 'Checked false',
              checked: false,
              onPressed: () {},
            ),
            CustomSimpleDialogOption.checked(
              text: 'Checked true',
              onPressed: () {},
            ),
            CustomSimpleDialogOption.icon(
              text: 'Icon One',
              icon: Icons.abc,
              onPressed: () {},
            ),
            CustomSimpleDialogOption.icon(
              text: 'Icon Two',
              icon: Icons.yard,
              onPressed: () {},
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
