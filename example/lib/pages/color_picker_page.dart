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
                text: 'Alert Dialog',
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
              ),
              CustomElevatedButton(
                text: 'General Dialog',
                onPressed: () => showGeneralDialog(
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return CustomScaffold(
                      body: ColorPicker.circle(onTap: print),
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                text: 'Bottom Sheet',
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return ColorPicker.rectangle(
                      title: '',
                      onTap: print,
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                text: 'Bottom Sheet (Compact)',
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return ColorPicker.compact(
                      title: '',
                      onTap: print,
                    );
                  },
                ),
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
