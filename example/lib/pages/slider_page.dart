import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CustomSlider(
            onChanged: print,
            max: 10,
          ),
          CustomSlider(
            labelText: 'Slider',
            onChanged: print,
            value: 5,
            divisions: 10,
            max: 10,
          ),
          CustomSlider(
            labelText: 'Slider (int)',
            onChanged: print,
            value: 2,
            divisions: 5,
            max: 5,
            prefixIcon: Icon(Icons.abc),
          ),
          CustomSlider(
            labelText: 'Slider (double)',
            onChanged: print,
            value: 2.5,
            divisions: 10,
            max: 5,
            prefixIcon: Icon(Icons.emoji_flags),
          ),
          CustomTextField(
            labelText: 'Text Field (for reference)',
            prefixIcon: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
