import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CustomSlider(
            onChanged: print,
            max: 10,
            value: 0,
          ),
          CustomSlider(
            labelText: 'Slider Two',
            onChanged: print,
            value: 5,
            divisions: 10,
            max: 10,
          ),
          CustomSlider(
            labelText: 'Slider Three (int value)',
            onChanged: print,
            value: 2,
            divisions: 5,
            max: 5,
            prefixIcon: Icons.abc,
          ),
          CustomSlider(
            labelText: 'Slider Four (double value)',
            onChanged: print,
            value: 2.5,
            divisions: 10,
            max: 5,
            prefixIcon: Icons.emoji_flags,
          ),
        ],
      ),
    );
  }
}
