import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DropdownFieldPage extends StatelessWidget {
  const DropdownFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: CustomOrientationBuilder(
        landscapeBuilder: (_) {
          return const SpacedRow(
            children: <Widget>[
              DropdownField<String>.bottomSheet(
                labelText: 'Dropdown',
                items: <String>['1', '2', '3'],
                onChanged: print,
                prefixIcon: Icon(Icons.gif_box),
              ),
              CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.abc),
                textInputAction: TextInputAction.next,
              ),
            ],
          );
        },
        portraitBuilder: (_) {
          return SpacedColumn(
            children: <Widget>[
              const CustomTextField(
                labelText: 'Text Field (for reference)',
                prefixIcon: Icon(Icons.gif_box),
                textInputAction: TextInputAction.next,
              ),
              const DropdownField<String>.bottomSheet(
                labelText: 'Dropdown',
                items: <String>['1', '2', '3'],
                onChanged: print,
                prefixIcon: Icon(Icons.gif_box),
              ),
              const DropdownField<BoxFit>.dialog(
                labelText: 'Dropdown Two',
                items: <BoxFit>[
                  BoxFit.contain,
                  BoxFit.cover,
                  BoxFit.fill,
                ],
                onChanged: print,
                prefixIcon: Icon(Icons.gif_outlined),
              ),
              DropdownField<BoxFit>.bottomSheet(
                labelText: 'Dropdown Three (Formatted)',
                items: const <BoxFit>[
                  BoxFit.contain,
                  BoxFit.cover,
                  BoxFit.fill,
                ],
                onChanged: print,
                displayStringForItem: (BoxFit v) => v.name,
                prefixIcon: const Icon(Icons.gif_box),
              ),
              DropdownField<BoxFit>.bottomSheet(
                labelText: 'Dropdown Four (Initial Value)',
                items: const <BoxFit>[
                  BoxFit.contain,
                  BoxFit.cover,
                  BoxFit.fill,
                ],
                onChanged: print,
                displayStringForItem: (BoxFit v) => v.name,
                prefixIcon: const Icon(Icons.select_all),
                value: BoxFit.fill,
              ),
              const DropdownField<String>.bottomSheet(
                labelText: 'Dropdown Five (Large Content)[bottomSheet]',
                items: <String>[
                  'Lorem ipsum dolor sit amet',
                  'consectetur adipiscing elit',
                  'sed do eiusmod tempor incididunt ut labore et dolore magna',
                ],
                onChanged: print,
                prefixIcon: Icon(Icons.density_large),
              ),
              const DropdownField<String>.dialog(
                labelText: 'Dropdown Five (Large Content)[dialog]',
                items: <String>[
                  'Lorem ipsum dolor sit amet',
                  'consectetur adipiscing elit',
                  'sed do eiusmod tempor incididunt ut labore et dolore magna',
                ],
                onChanged: print,
                prefixIcon: Icon(Icons.density_large),
              ),
              DropdownField<String>.bottomSheet(
                labelText: 'Dropdown Six (Long List)[bottomSheet]',
                items: List<String>.generate(
                  50,
                  (int index) => 'Item ${index + 1}',
                ),
                onChanged: print,
                prefixIcon: const Icon(Icons.select_all),
              ),
              DropdownField<String>.dialog(
                labelText: 'Dropdown Six (Long List)[dialog]',
                items: List<String>.generate(
                  50,
                  (int index) => 'Item ${index + 1}',
                ),
                onChanged: print,
                prefixIcon: const Icon(Icons.select_all),
              ),
              const _DropdownTest(),
            ],
          );
        },
      ),
    );
  }
}

class _DropdownTest extends StatefulWidget {
  const _DropdownTest();

  @override
  State<_DropdownTest> createState() => __DropdownTestState();
}

class __DropdownTestState extends State<_DropdownTest> {
  BoxFit? _value;

  @override
  void initState() {
    super.initState();
    _value = BoxFit.fill;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownField<BoxFit>.bottomSheet(
          labelText: 'Dropdown Seven (On State Changed)',
          items: const <BoxFit>[
            BoxFit.contain,
            BoxFit.cover,
            BoxFit.fill,
          ],
          onChanged: print,
          displayStringForItem: (BoxFit v) => v.name,
          prefixIcon: const Icon(Icons.select_all),
          value: _value,
        ),
        CustomElevatedButton(
          child: const Text('Set State ↑'),
          onPressed: () => setState(() {
            _value = BoxFit.contain;
          }),
        ),
      ],
    );
  }
}
