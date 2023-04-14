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
            title: 'Accordion 1',
            child: Text('Some text you want to show/hide.'),
          ),
          Accordion(
            isOpen: true,
            title: 'Accordion 2',
            child: Column(
              children: const <Widget>[
                Text('Row one'),
                Text('Row two'),
              ],
            ),
          ),
          Accordion(
            onTap: print,
            title: 'Accordion 3',
            child: Container(
              color: Theme.of(context).primaryColor,
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
