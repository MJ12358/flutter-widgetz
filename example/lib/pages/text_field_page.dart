import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

List<String> _autocompletes = <String>[
  'dart',
  'flutter',
  'go',
  'java',
  'javascript',
  'php',
  'ruby',
];

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: CustomOrientationBuilder(
        landscapeBuilder: (_) => const _Landscape(),
        portraitBuilder: (_) => const _Portrait(),
      ),
    );
  }
}

class _Landscape extends StatelessWidget {
  const _Landscape();

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: <Widget>[
        const SpacedRow(
          children: <Widget>[
            CustomTextField(
              labelText: 'Row1',
              prefixIcon: Icons.rotate_90_degrees_cw,
            ),
            CustomTextField(
              labelText: 'Row2',
              prefixIcon: Icons.missed_video_call,
              helpText: 'Help Text',
            ),
            CustomTextField(
              labelText: 'Row3',
              prefixIcon: Icons.rotate_90_degrees_ccw,
            ),
          ],
        ),
        SpacedRow(
          children: <Widget>[
            const SpacedColumn(
              children: <Widget>[
                CustomTextField(
                  labelText: 'One',
                  prefixIcon: Icons.one_k,
                ),
                CustomTextField(
                  labelText: 'Two',
                  prefixIcon: Icons.two_k,
                ),
              ],
            ),
            SpacedColumn(
              children: <Widget>[
                CustomAutocomplete<String>(
                  onChanged: print,
                  onSelected: print,
                  prefixIcon: Icons.search,
                  optionsBuilder: (String v) => _autocompletes
                      .where((String e) => e.contains(v))
                      .toList(),
                ),
                CustomAutocomplete<String>(
                  onChanged: print,
                  onSelected: print,
                  prefixIcon: Icons.search,
                  optionsBuilder: (String v) => _autocompletes
                      .where((String e) => e.contains(v))
                      .toList(),
                ),
              ],
            ),
            const SpacedColumn(
              children: <Widget>[
                CustomTextField(
                  // labelText: 'Three',
                  prefixIcon: Icons.three_k,
                ),
                CustomTextField(
                  labelText: 'Four',
                  prefixIcon: Icons.four_k,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Portrait extends StatelessWidget {
  const _Portrait();

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: <Widget>[
        const CustomTextField(
          labelText: 'One',
          prefixIcon: Icons.one_k,
          textInputAction: TextInputAction.next,
        ),
        const CustomTextField(
          labelText: 'Two',
          prefixIcon: Icons.two_k,
          helpText: 'Help Text',
          textInputAction: TextInputAction.previous,
        ),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue v) =>
              _autocompletes.where((String e) => e.contains(v.text)).toList(),
        ),
        CustomAutocomplete<String>(
          onChanged: print,
          onSelected: print,
          prefixIcon: Icons.search,
          optionsBuilder: (String v) =>
              _autocompletes.where((String e) => e.contains(v)).toList(),
        ),
        const CustomTextField(
          labelText: 'Three',
          prefixIcon: Icons.three_k,
          textInputAction: TextInputAction.next,
        ),
        const CustomTextField(
          labelText: 'Four',
          prefixIcon: Icons.four_k,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
