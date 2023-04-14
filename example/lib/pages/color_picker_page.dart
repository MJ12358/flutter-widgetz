import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorPicker(onTap: print);
  }
}
