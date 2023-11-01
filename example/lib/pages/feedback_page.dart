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
            onChanged: print,
          ),
          FeedbackBar.filled(
            header: const Text('Filled'),
            onChanged: print,
          ),
          FeedbackBar.outlined(
            header: const Text('Outlined (rtl)'),
            footer: const Text('Footer'),
            onChanged: print,
            rtl: true,
          ),
          FeedbackBar.outlined(
            color: Colors.black,
            header: const Text('Outlined'),
            onChanged: print,
          ),
          SizedBox(
            width: 60,
            child: FeedbackBar.outlined(
              color: Colors.black,
              header: const Text('Outlined'),
              onChanged: print,
              orientation: Orientation.portrait,
            ),
          ),
        ],
      ),
    );
  }
}
