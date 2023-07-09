import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

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
    return const SpacedColumn(
      children: <Widget>[
        SpacedRow(
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
            SpacedColumn(
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
                CustomTextField(
                  labelText: 'Three',
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
    return const SpacedColumn(
      children: <Widget>[
        CustomTextField(
          labelText: 'One',
          prefixIcon: Icons.one_k,
          textInputAction: TextInputAction.next,
        ),
        CustomTextField(
          labelText: 'Two',
          prefixIcon: Icons.two_k,
          helpText: 'Help Text',
          textInputAction: TextInputAction.previous,
        ),
        CustomTextField(
          labelText: 'Three',
          prefixIcon: Icons.three_k,
          textInputAction: TextInputAction.next,
        ),
        CustomTextField(
          labelText: 'Four',
          prefixIcon: Icons.four_k,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
