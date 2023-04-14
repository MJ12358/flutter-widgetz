import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          RatingBar(
            onChanged: print,
          ),
          RatingBar(
            onChanged: print,
            color: Colors.purple,
            value: 3.5,
          ),
          RatingBar(
            onChanged: print,
            color: Colors.deepOrange,
            unratedColor: Colors.black,
            max: 10,
            value: 6.5,
            size: 25,
          ),
        ],
      ),
    );
  }
}
