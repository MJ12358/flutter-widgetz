import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AccordionPage extends StatelessWidget {
  const AccordionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const Accordion(
            title: 'Accordion One',
            child: Text('Some text you want to show/hide.'),
          ),
          Accordion(
            isOpen: true,
            title: 'Accordion Two',
            child: Column(
              children: const <Widget>[
                Text('Row one'),
                Text('Row two'),
              ],
            ),
          ),
          Accordion(
            onTap: print,
            title: 'Accordion Three',
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('1'),
                  Text('2'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
