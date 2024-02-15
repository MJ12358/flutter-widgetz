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
          CustomElevatedButton(
            child: const Text('Scrollable'),
            onPressed: () => _showScrollableDialog(context),
          ),
        ],
      ),
    );
  }

  void _showDefaultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return const SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Text('One'),
            ),
            SimpleDialogOption(
              child: Text('Two'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.list(
          children: const <Widget>[
            CustomSimpleDialogOption(
              child: Text('One'),
            ),
            CustomSimpleDialogOption(
              child: Text('Two'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomIconDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.list(
          children: <Widget>[
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.abc),
              child: const Text('One'),
            ),
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.yard),
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
      builder: (_) {
        return CustomDialog.list(
          children: <Widget>[
            CustomSimpleDialogOption.checked(
              checked: false,
              child: const Text('One'),
            ),
            CustomSimpleDialogOption.checked(
              child: const Text('Two'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.list(
          title: const Text('Custom Dialog'),
          children: <Widget>[
            const CustomSimpleDialogOption(
              child: Text('Custom'),
            ),
            CustomSimpleDialogOption.checked(
              checked: false,
              onPressed: () => print('checked false'),
              child: const Text('Checked false'),
            ),
            CustomSimpleDialogOption.checked(
              onPressed: () => print('checked true'),
              child: const Text('Checked true'),
            ),
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.abc),
              onPressed: () => print('icon one'),
              child: const Text('Icon One'),
            ),
            CustomSimpleDialogOption.icon(
              icon: const Icon(Icons.yard),
              onPressed: () => print('icon two'),
              child: const Text('Icon Two'),
            ),
            CustomSimpleDialogOption.tile(
              onPressed: () => print('tile one'),
              child: const Text('Tile one'),
            ),
          ],
        );
      },
    );
  }

  void _showScrollableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.list(
          title: const Text('Scrollable Dialog'),
          children: <Widget>[
            for (int i = 0; i < 25; i++)
              CustomSimpleDialogOption.icon(
                icon: const Icon(Icons.abc),
                child: Text('Icon $i'),
              ),
          ],
        );
      },
    );
  }
}
