import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Default Text'),
            CustomText.help(
              'Text1',
              help: Text('Help Text'),
            ),
            SizedBox(
              width: 200,
              child: CustomText.help(
                'Text2',
                help: Text('Help Text'),
              ),
            ),
            CustomText.help(
              'Text3',
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              help: Text('Help Text'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomTextField(
              labelText: 'Text Field',
              prefixIcon: Icon(Icons.text_fields),
              help: Text('Help Text'),
            ),
            CustomInputDecorator(
              labelText: 'Input Decorator Label1',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              help: Text('Input Decorator Help1'),
              child: Text('Input Decorator Child1'),
            ),
            CustomInputDecorator(
              labelText: 'Input Decorator Label2',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 5.0,
                ),
              ),
              help: Text('Input Decorator Help2'),
              child: Text('Input Decorator Child2'),
            ),
          ],
        ),
      ),
    );
  }
}
