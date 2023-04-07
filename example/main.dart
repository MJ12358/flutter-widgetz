import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CustomBody(
        child: SpacedColumn(
          children: <Widget>[
            const CustomPlaceholder(
              text: 'Hi There',
            ),
            CustomElevatedButton(
              onPressed: () {},
              text: 'A Button',
            ),
          ],
        ),
      ),
    );
  }
}
