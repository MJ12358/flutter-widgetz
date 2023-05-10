import 'package:flutter/material.dart';
import 'package:flutter_themez/flutter_themez.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';
import 'package:flutter_widgetz_example/pages/accordion_page.dart';
import 'package:flutter_widgetz_example/pages/alert_page.dart';
import 'package:flutter_widgetz_example/pages/avatar_page.dart';
import 'package:flutter_widgetz_example/pages/carousel_page.dart';
import 'package:flutter_widgetz_example/pages/checkbox_page.dart';
import 'package:flutter_widgetz_example/pages/color_picker_page.dart';
import 'package:flutter_widgetz_example/pages/counter_input_page.dart';
import 'package:flutter_widgetz_example/pages/date_input_page.dart';
import 'package:flutter_widgetz_example/pages/dialogs_page.dart';
import 'package:flutter_widgetz_example/pages/divider_page.dart';
import 'package:flutter_widgetz_example/pages/dropdown_input_page.dart';
import 'package:flutter_widgetz_example/pages/elevated_button_page.dart';
import 'package:flutter_widgetz_example/pages/list_view_page.dart';
import 'package:flutter_widgetz_example/pages/placeholder_page.dart';
import 'package:flutter_widgetz_example/pages/popup_menu_page.dart';
import 'package:flutter_widgetz_example/pages/radio_page.dart';
import 'package:flutter_widgetz_example/pages/rating_page.dart';
import 'package:flutter_widgetz_example/pages/scaffold_page.dart';
import 'package:flutter_widgetz_example/pages/search_bar_page.dart';
import 'package:flutter_widgetz_example/pages/slider_page.dart';
import 'package:flutter_widgetz_example/pages/sliver_grid_page.dart';
import 'package:flutter_widgetz_example/pages/sliver_list_page.dart';

/// To run the example app, clone/fork the repo!

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
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

const List<PageInfo> _pages = <PageInfo>[
  PageInfo(Icons.account_tree, AccordionPage(), 'Accordions'),
  PageInfo(Icons.notifications, AlertPage(), 'Alerts'),
  PageInfo(Icons.person, AvatarPage(), 'Avatars'),
  PageInfo(Icons.roundabout_left, CarouselPage(), 'Carousel'),
  PageInfo(Icons.check_box, CheckboxPage(), 'Checkboxes'),
  PageInfo(Icons.color_lens, ColorPickerPage(), 'Color Picker'),
  PageInfo(Icons.numbers, CounterInputPage(), 'Counter Input'),
  PageInfo(Icons.date_range, DateInputPage(), 'Date Input'),
  PageInfo(Icons.dialpad_outlined, DialogsPage(), 'Dialogs'),
  PageInfo(Icons.space_bar, DividerPage(), 'Dividers'),
  PageInfo(Icons.arrow_drop_down, DropdownInputPage(), 'Dropdown Input'),
  PageInfo(Icons.gamepad, ElevatedButtonPage(), 'Elevated Buttons'),
  PageInfo(Icons.list, ListViewPage(), 'List View'),
  PageInfo(Icons.business, PlaceholderPage(), 'Placeholders'),
  PageInfo(Icons.phonelink_setup_sharp, PopupMenuPage(), 'Popup Menu'),
  PageInfo(Icons.radio, RadioPage(), 'Radios'),
  PageInfo(Icons.star, RatingPage(), 'Rating Bar'),
  PageInfo(Icons.search, SearchBarPage(), 'Search Bar'),
  PageInfo(Icons.scale, ScaffoldPage(), 'Scaffold'),
  PageInfo(Icons.tune, SliderPage(), 'Sliders'),
  PageInfo(Icons.grid_4x4, SliverGridPage(), 'Sliver Grid'),
  PageInfo(Icons.list, SliverListPage(), 'Sliver List'),
];
