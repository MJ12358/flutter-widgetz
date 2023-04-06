import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

void main() {
  testWidgets('colorPicker', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomColorPicker(onTap: (_) {}),
        ),
      ),
    );

    expect(find.text('Choose Color'), findsOneWidget);
  });
}
