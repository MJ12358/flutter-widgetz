import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          FeedbackBar.outlined(
            header: const Text('Outlined'),
            footer: const Text('Footer'),
            onChanged: print,
          ),
          FeedbackBar.outlined(
            header: const Text('Outlined (rtl)'),
            footer: const Text('Footer'),
            onChanged: print,
            rtl: true,
          ),
          FeedbackBar.filled(
            header: const Text('Filled'),
            footer: const Text('Footer'),
            onChanged: print,
          ),
          FeedbackBar.outlined(
            color: Colors.black,
            headerText: 'Outlined (color)',
            onChanged: print,
          ),
          SizedBox(
            width: 50,
            child: FeedbackBar.outlined(
              color: Colors.black,
              headerText: 'Outlined (color)',
              onChanged: print,
              orientation: Orientation.portrait,
            ),
          ),
        ],
      ),
    );
  }
}
