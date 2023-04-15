import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          // ColorPicker(onTap: print),
          CustomElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) {
                return SimpleDialog(
                  children: <Widget>[ColorPicker(onTap: print)],
                );
              },
            ),
            text: 'Dialog',
          ),
          CustomElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) {
                return ColorPicker(onTap: print);
              },
            ),
            text: 'Bottom Sheet',
          ),
        ],
      ),
    );
  }
}
