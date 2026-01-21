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
                onChanged: print,
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
                child: const Text('Alert Dialog'),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return CustomDialog(
                      title: const Text('Choose Color'),
                      child: ColorPicker.rectangle(
                        onTap: print,
                      ),
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                child: const Text('General Dialog'),
                onPressed: () => showGeneralDialog(
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return CustomScaffold(
                      body: ColorPicker.circle(
                        onTap: print,
                      ),
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                child: const Text('Bottom Sheet'),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return ColorPicker.rectangle(
                      onTap: print,
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                child: const Text('Bottom Sheet (Compact)'),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return ColorPicker.compact(
                      onTap: print,
                    );
                  },
                ),
              ),
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.color_lens),
              ),
              const ColorField.bottomSheet(
                labelText: 'Bottom Sheet',
                onChanged: print,
              ),
              const ColorField.dialog(
                labelText: 'Dialog',
                onChanged: print,
              ),
              ColorField.bottomSheet(
                labelText: 'Color (Formatted)[bottomSheet]',
                pickerShape: BoxShape.rectangle,
                value: Colors.blue,
                onChanged: print,
                displayStringForColor: (Color? color) {
                  return color?.toString() ?? '';
                },
              ),
              ColorField.dialog(
                labelText: 'Color (Formatted)[dialog]',
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
