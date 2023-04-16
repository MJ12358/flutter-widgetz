import 'package:flutter/material.dart';
import 'package:flutter_themez/flutter_themez.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';
import 'package:flutter_widgetz_example/pages/accordion_page.dart';
import 'package:flutter_widgetz_example/pages/alert_page.dart';
import 'package:flutter_widgetz_example/pages/avatar_page.dart';
import 'package:flutter_widgetz_example/pages/checkbox_page.dart';
import 'package:flutter_widgetz_example/pages/color_picker_page.dart';
import 'package:flutter_widgetz_example/pages/counter_input_page.dart';
import 'package:flutter_widgetz_example/pages/date_input_page.dart';
import 'package:flutter_widgetz_example/pages/divider_page.dart';
import 'package:flutter_widgetz_example/pages/dropdown_input_page.dart';
import 'package:flutter_widgetz_example/pages/elevated_button_page.dart';
import 'package:flutter_widgetz_example/pages/placeholder_page.dart';
import 'package:flutter_widgetz_example/pages/radio_page.dart';
import 'package:flutter_widgetz_example/pages/rating_page.dart';
import 'package:flutter_widgetz_example/pages/scaffold_page.dart';
import 'package:flutter_widgetz_example/pages/search_bar_page.dart';
import 'package:flutter_widgetz_example/pages/slider_page.dart';

/// To run the example app, clone/fork the repo!

const List<PageInfo> _pages = <PageInfo>[
  PageInfo(Icons.account_tree, AccordionPage(), 'Accordions'),
  PageInfo(Icons.notifications, AlertPage(), 'Alerts'),
  PageInfo(Icons.person, AvatarPage(), 'Avatars'),
  PageInfo(Icons.check_box, CheckboxPage(), 'Checkboxes'),
  PageInfo(Icons.color_lens, ColorPickerPage(), 'Color Picker'),
  PageInfo(Icons.numbers, CounterInputPage(), 'Counter Input'),
  PageInfo(Icons.date_range, DateInputPage(), 'Date Input'),
  PageInfo(Icons.space_bar, DividerPage(), 'Dividers'),
  PageInfo(Icons.arrow_drop_down, DropdownInputPage(), 'Dropdown Input'),
  PageInfo(Icons.gamepad, ElevatedButtonPage(), 'Elevated Buttons'),
  PageInfo(Icons.business, PlaceholderPage(), 'Placeholders'),
  PageInfo(Icons.radio, RadioPage(), 'Radios'),
  PageInfo(Icons.star, RatingPage(), 'Ratings'),
  PageInfo(Icons.search, SearchBarPage(), 'Search Bar'),
  PageInfo(Icons.scale, ScaffoldPage(), 'Scaffold'),
  PageInfo(Icons.tune, SliderPage(), 'Sliders'),
];

void main() {
  runApp(const _Main());
}

class _Main extends StatefulWidget {
  const _Main({Key? key}) : super(key: key);

  @override
  State<_Main> createState() => _MainState();
}

class _MainState extends State<_Main> {
  late final PageController _controller;
  late PageInfo _currentPage;
  late bool _isDark;
  late FlutterThemez _theme;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _currentPage = _pages[0];
    _isDark = false;
    _theme = FlutterThemez();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgetz Example',
      home: CustomScaffold(
        appBar: AppBar(
          title: Text(_currentPage.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(_isDark ? Icons.dark_mode : Icons.sunny),
              onPressed: () => setState(() {
                _isDark = !_isDark;
              }),
            )
          ],
        ),
        drawer: CustomDrawer(
          header: const Text(
            'Flutter Widgetz!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          itemCount: _pages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(_pages[index].icon),
              title: Text(_pages[index].title),
              onTap: () {
                _controller.jumpToPage(index);
                Navigator.pop(context);
              },
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          onTap: (_) {},
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: PageView.builder(
          controller: _controller,
          onPageChanged: (int index) => setState(() {
            _currentPage = _pages[index];
          }),
          itemCount: _pages.length,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index].page;
          },
        ),
      ),
      theme: _isDark ? _theme.dark() : _theme.light(),
    );
  }
}

class PageInfo {
  const PageInfo(
    this.icon,
    this.page,
    this.title,
  );

  final IconData icon;
  final Widget page;
  final String title;
}