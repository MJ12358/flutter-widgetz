// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class OrientationPage extends StatelessWidget {
  const OrientationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),

      /// test the forcing of orientation
      // child: CustomOrientationBuilder.landscape(
      //   builder: (BuildContext context) {
      //     return const SpacedRow(
      //       children: <Widget>[
      //         Text('One'),
      //         Text('Two'),
      //       ],
      //     );
      //   },
      // ),
      child: CustomOrientationBuilder(
        landscapeBuilder: (BuildContext context) {
          print('landscapeBuilder');
          return const SpacedRow(
            children: <Widget>[
              Text('One'),
              Text('Two'),
            ],
          );
        },
        portraitBuilder: (BuildContext context) {
          print('portraitBuilder');
          return const SpacedColumn(
            children: <Widget>[
              Text('One'),
              Text('Two'),
            ],
          );
        },
        onChanged: print,
      ),
    );
  }
}
