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
            child: const Text('Checkbox'),
            onPressed: () => _showCustomCheckboxDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Radio'),
            onPressed: () => _showCustomRadioDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Scrollable'),
            onPressed: () => _showScrollableDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Reorderable'),
            onPressed: () => _showReorderableDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Alert'),
            onPressed: () => _showCustomAlertDialog(context),
          ),
          CustomElevatedButton(
            child: const Text('Simple'),
            onPressed: () => _showCustomSimpleDialog(context),
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
          title: const Text('Custom'),
          fadedScrollable: true,
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
            CustomSimpleDialogOption.tile(
              onPressed: () => print('tile two'),
              child: const Text('Tile two'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomCheckboxDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.checkbox(
          title: const Text('Checkbox'),
          initialValues: const <String>['One', 'Two', 'Three'],
          currentValues: const <String>['One'],
          onChanged: (String? value) => print('value: $value'),
          displayStringForValue: (String value) => 'Value $value',
        );
      },
    );
  }

  void _showCustomRadioDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog<String>.radio(
          title: const Text('Radio'),
          values: const <String>['One', 'Two', 'Three'],
          groupValue: 'One',
          onChanged: (String? value) => print('value: $value'),
          displayStringForValue: (String value) => 'Value $value',
        );
      },
    );
  }

  void _showScrollableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.list(
          title: const Text('Scrollable'),
          fadedScrollable: true,
          children: <Widget>[
            for (int i = 0; i < 25; i++)
              CustomSimpleDialogOption.icon(
                icon: const Icon(Icons.abc),
                child: Text('Index $i'),
              ),
          ],
        );
      },
    );
  }

  void _showReorderableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.reorderable(
          title: const Text('Reorderable'),
          fadedScrollable: true,
          onReorder: (int oldIndex, int newIndex) {
            print('oldIndex: $oldIndex, newIndex: $newIndex');
          },
          children: <Widget>[
            for (int i = 0; i < 25; i++)
              ListTile(
                key: ValueKey<int>(i),
                tileColor: i.isOdd ? Colors.grey[200] : null,
                title: Text('Index $i'),
              ),
          ],
        );
      },
    );
  }

  void _showCustomAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.alert(
          context: context,
          title: const Text('Alert'),
          child: const Text('This is a custom alert dialog.'),
        );
      },
    ).then(print);
  }

  void _showCustomSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog.simple(
          title: const Text('Simple'),
          child: const Text('This is a custom simple dialog.'),
        );
      },
    );
  }
}
