import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const RatingBar(
            onChanged: print,
          ),
          const RatingBar(
            onChanged: print,
            color: Colors.purple,
            value: 3.5,
          ),
          RatingBar(
            onChanged: print,
            color: Colors.deepOrange,
            unratedColor: Colors.deepOrange.withAlpha(50),
            max: 10,
            value: 6.5,
            size: 25,
          ),
          const RatingBar.static(
            value: 2.5,
          ),
          Container(
            color: Colors.lime,
            child: const RatingBar(
              value: 4,
            ),
          ),
          const RatingSummary(
            fiveStarCount: 40,
            fourStarCount: 26,
            threeStarCount: 18,
            twoStarCount: 11,
            oneStarCount: 3,
          ),
          const RatingSummary(
            backgroundColor: Colors.grey,
            color: Colors.amber,
            borderRadius: 8.0,
            height: 16.0,
            fiveStarCount: 52,
            fourStarCount: 8,
            threeStarCount: 5,
            twoStarCount: 9,
            oneStarCount: 23,
          ),
          const RatingSummary(
            backgroundColor: Color(0xFFacb3b9),
            color: Color(0xFF69758e),
            fiveStarCount: 75,
            fourStarCount: 26,
            threeStarCount: 18,
            twoStarCount: 11,
            oneStarCount: 3,
          ),
        ],
      ),
    );
  }
}
