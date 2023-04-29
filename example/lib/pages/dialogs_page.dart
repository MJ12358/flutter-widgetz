import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CustomElevatedButton(
            text: 'Default Dialog',
            onPressed: () => _showDefaultDialog(context),
          ),
          CustomElevatedButton(
            text: 'Custom Dialog',
            onPressed: () => _showCustomDialog(context),
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
              child: const Text('two'),
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
              child: const Text('two'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
