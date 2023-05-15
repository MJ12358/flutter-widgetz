import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          CustomElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: ColorPicker(
                    onTap: print,
                    shape: BoxShape.rectangle,
                  ),
                );
              },
            ),
            text: 'Alert Dialog',
          ),
          CustomElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) {
                return ColorPicker(onTap: print);
              },
            ),
            text: 'General Dialog',
          ),
          CustomElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) {
                return ColorPicker(
                  onTap: print,
                  shape: BoxShape.rectangle,
                );
              },
            ),
            text: 'Bottom Sheet',
          ),
        ],
      ),
    );
  }
}
