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
              prefixIcon: Icon(Icons.rotate_90_degrees_cw),
            ),
            CustomTextField(
              labelText: 'Row2',
              prefixIcon: Icon(Icons.missed_video_call),
              help: Text('Help Text'),
            ),
            CustomTextField(
              labelText: 'Row3',
              prefixIcon: Icon(Icons.rotate_90_degrees_ccw),
            ),
          ],
        ),
        SpacedRow(
          children: <Widget>[
            const SpacedColumn(
              children: <Widget>[
                CustomTextField(
                  labelText: 'One',
                  prefixIcon: Icon(Icons.one_k),
                ),
                CustomTextField(
                  labelText: 'Two',
                  prefixIcon: Icon(Icons.two_k),
                ),
              ],
            ),
            SpacedColumn(
              children: <Widget>[
                CustomAutocomplete<String>(
                  onChanged: print,
                  onSelected: print,
                  prefixIcon: const Icon(Icons.search),
                  optionsBuilder: (String v) => _autocompletes
                      .where((String e) => e.contains(v))
                      .toList(),
                ),
                CustomAutocomplete<String>(
                  onChanged: print,
                  onSelected: print,
                  prefixIcon: const Icon(Icons.search),
                  optionsBuilder: (String v) => _autocompletes
                      .where((String e) => e.contains(v))
                      .toList(),
                ),
              ],
            ),
            const SpacedColumn(
              children: <Widget>[
                CustomTextField(
                  labelText: 'Three',
                  prefixIcon: Icon(Icons.three_k),
                ),
                CustomTextField(
                  labelText: 'Four',
                  prefixIcon: Icon(Icons.four_k),
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
          labelText: 'One (Next)',
          prefixIcon: Icon(Icons.one_k),
          textInputAction: TextInputAction.next,
        ),
        const CustomTextField(
          labelText: 'Two (Previous)',
          prefixIcon: Icon(Icons.two_k),
          help: Text('This is some help text.'),
          textInputAction: TextInputAction.previous,
        ),
        const CustomInputDecorator(
          labelText: 'Input Decorator',
          prefixIcon: Icon(Icons.abc),
          child: Text('Hello'),
        ),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue v) =>
              _autocompletes.where((String e) => e.contains(v.text)).toList(),
        ),
        CustomAutocomplete<String>(
          onChanged: print,
          onSelected: print,
          labelText: 'Custom Autocomplete',
          prefixIcon: const Icon(Icons.search),
          optionsBuilder: (String v) =>
              _autocompletes.where((String e) => e.contains(v)).toList(),
        ),
        CustomAutocomplete<String>(
          onChanged: print,
          onSelected: print,
          initialValue: _autocompletes[2],
          labelText: 'Custom Autocomplete 2',
          prefixIcon: const Icon(Icons.search),
          optionsBuilder: (String v) =>
              _autocompletes.where((String e) => e.contains(v)).toList(),
        ),
        const CustomTextField(
          labelText: 'Three (Next)',
          prefixIcon: Icon(Icons.three_k),
          textInputAction: TextInputAction.next,
        ),
        const CustomTextField(
          labelText: 'Four (NewLine)',
          prefixIcon: Icon(Icons.four_k),
          minLines: 1,
          maxLines: 2,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
        ),
        const CustomTextField(
          labelText: 'Five (Done)',
          prefixIcon: Icon(Icons.four_k),
          textInputAction: TextInputAction.done,
        ),
        const _StatefulText(),
      ],
    );
  }
}

class _StatefulText extends StatefulWidget {
  const _StatefulText();

  @override
  State<_StatefulText> createState() => __StatefulTextState();
}

class __StatefulTextState extends State<_StatefulText> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextField(
          labelText: 'Stateful Text Field',
          prefixIcon: const Icon(Icons.text_fields),
          value: _value,
          onChanged: (String v) {
            setState(() {
              _value = v;
            });
          },
        ),
        Button.brand(
          onPressed: () {
            setState(() {
              _value = 'Rebuilt at ${DateTime.now()}';
            });
          },
          child: const Text('Rebuild'),
        ),
      ],
    );
  }
}
