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
              ColorField(
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
                    return CustomScaffold(body: ColorPicker(onTap: print));
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
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icons.color_lens,
              ),
              const ColorField(
                onChanged: print,
              ),
              const ColorField(
                labelText: 'Color (Initial Value)',
                value: Colors.amber,
              ),
              ColorField(
                labelText: 'Color (Formatted)',
                value: Colors.blue,
                onChanged: print,
                displayStringForColor: (Color? color) {
                  if (color == null) {
                    return '';
                  }
                  return Color(color.value).toString();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
