import 'package:flutter/material.dart';
import 'package:flutter_extensionz/flutter_extensionz.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  void _showSnackBar(BuildContext context, Widget content) {
    context.showSnackBar(content);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          FeedbackBar.outlined(
            header: const Text('Outlined'),
            onChanged: (int i) => _showSnackBar(context, Text('Outlined: $i')),
          ),
          FeedbackBar.filled(
            header: const Text('Filled'),
            onChanged: (int i) => _showSnackBar(context, Text('Filled: $i')),
          ),
          FeedbackBar.outlined(
            header: const Text('Outlined (rtl)'),
            footer: const Text('Footer'),
            onChanged: (int i) => _showSnackBar(context, Text('Outlined: $i')),
            rtl: true,
          ),
          FeedbackBar.outlined(
            color: Colors.black,
            header: const Text('Outlined'),
            onChanged: (int i) => _showSnackBar(context, Text('Outlined: $i')),
          ),
          SizedBox(
            width: 60,
            child: FeedbackBar.outlined(
              color: Colors.black,
              header: const Text('Outlined'),
              onChanged: (int i) =>
                  _showSnackBar(context, Text('Outlined: $i')),
              orientation: Orientation.portrait,
            ),
          ),
        ],
      ),
    );
  }
}
