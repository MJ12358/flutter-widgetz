import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

void main() {
  const List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.abc),
      label: 'ABC',
    ),
  ];

  void onTap(int value) {}

  testWidgets('bottomNavigationBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            items: items,
            onTap: onTap,
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('ABC'), findsOneWidget);
  });
}
