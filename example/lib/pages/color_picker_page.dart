import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: CustomOrientationBuilder(
        landscapeBuilder: (_) {
          return const SpacedRow(
            children: <Widget>[
              ColorField.bottomSheet(
                value: Color(0xFFFFFFFF),
              ),
              CustomTextField(
                labelText: 'Text Field (for reference)',
              ),
            ],
          );
        },
        portraitBuilder: (_) {
          return SpacedColumn(
            children: <Widget>[
              CustomElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: ColorPicker.rectangle(
                        onTap: print,
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
                    return CustomScaffold(
                      body: ColorPicker.circle(onTap: print),
                    );
                  },
                ),
                text: 'General Dialog',
              ),
              CustomElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return ColorPicker.rectangle(
                      onTap: print,
                    );
                  },
                ),
                text: 'Bottom Sheet',
              ),
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icons.color_lens,
              ),
              const ColorField.bottomSheet(
                labelText: 'Bottom Sheet',
                onChanged: print,
              ),
              const ColorField.dialog(
                labelText: 'Dialog',
                value: Colors.amber,
              ),
              ColorField.bottomSheet(
                labelText: 'Color (Formatted)',
                pickerShape: BoxShape.rectangle,
                value: Colors.blue,
                onChanged: print,
                displayStringForColor: (Color? color) {
                  return color?.toString() ?? '';
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
