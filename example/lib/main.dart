import 'package:flutter/material.dart';
import 'package:flutter_themez/flutter_themez.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';
import 'package:flutter_widgetz_example/pages/accordion_page.dart';
import 'package:flutter_widgetz_example/pages/alert_page.dart';
import 'package:flutter_widgetz_example/pages/avatar_page.dart';
import 'package:flutter_widgetz_example/pages/badge_page.dart';
import 'package:flutter_widgetz_example/pages/button_page.dart';
import 'package:flutter_widgetz_example/pages/carousel_page.dart';
import 'package:flutter_widgetz_example/pages/checkbox_page.dart';
import 'package:flutter_widgetz_example/pages/color_picker_page.dart';
import 'package:flutter_widgetz_example/pages/counter_field_page.dart';
import 'package:flutter_widgetz_example/pages/date_field_page.dart';
import 'package:flutter_widgetz_example/pages/dialogs_page.dart';
import 'package:flutter_widgetz_example/pages/divider_page.dart';
import 'package:flutter_widgetz_example/pages/dropdown_field_page.dart';
import 'package:flutter_widgetz_example/pages/link_page.dart';
import 'package:flutter_widgetz_example/pages/list_view_page.dart';
import 'package:flutter_widgetz_example/pages/orienatation_page.dart';
import 'package:flutter_widgetz_example/pages/picklist_page.dart';
import 'package:flutter_widgetz_example/pages/placeholder_page.dart';
import 'package:flutter_widgetz_example/pages/popup_menu_page.dart';
import 'package:flutter_widgetz_example/pages/radio_page.dart';
import 'package:flutter_widgetz_example/pages/rating_page.dart';
import 'package:flutter_widgetz_example/pages/scaffold_page.dart';
import 'package:flutter_widgetz_example/pages/search_bar_page.dart';
import 'package:flutter_widgetz_example/pages/slider_page.dart';
import 'package:flutter_widgetz_example/pages/sliver_grid_page.dart';
import 'package:flutter_widgetz_example/pages/sliver_list_page.dart';
import 'package:flutter_widgetz_example/pages/time_field_page.dart';

/// To run the example app, clone/fork the repo!

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  late final PageController _controller;
  late PageInfo _currentPage;
  late bool _isDark;
  late bool _showMaterialGrid;
  late FlutterThemez _theme;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _currentPage = _pages[0];
    _isDark = false;
    _showMaterialGrid = false;
    _theme = FlutterThemez();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: _showMaterialGrid,
      title: 'Flutter Widgetz Example',
      home: CustomScaffold(
        appBar: AppBar(
          title: Text(_currentPage.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.grid_3x3),
              onPressed: _onShowMaterialGrid,
            ),
            IconButton(
              icon: Icon(_isDark ? Icons.dark_mode : Icons.sunny),
              onPressed: _onDarkModeChanged,
            ),
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
              onTap: () => _onDrawerChanged(context, index),
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(
          onTap: print,
          items: <BottomNavigationBarItem>[
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
          onPageChanged: _onPageChanged,
          itemCount: _pages.length,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index].page;
          },
        ),
      ),
      theme: _isDark ? _theme.dark() : _theme.light(),
      // theme: _isDark ? ThemeData.dark() : ThemeData.light(),
    );
  }

  void _onShowMaterialGrid() {
    setState(() {
      _showMaterialGrid = !_showMaterialGrid;
    });
  }

  void _onDarkModeChanged() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  void _onDrawerChanged(BuildContext context, int index) {
    _controller.jumpToPage(index);
    Navigator.pop(context);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = _pages[index];
    });
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
  PageInfo(Icons.badge, BadgePage(), 'Badges'),
  PageInfo(Icons.gamepad, ButtonPage(), 'Buttons'),
  PageInfo(Icons.roundabout_left, CarouselPage(), 'Carousel'),
  PageInfo(Icons.check_box, CheckboxPage(), 'Checkboxes'),
  PageInfo(Icons.color_lens, ColorPickerPage(), 'Color Picker'),
  PageInfo(Icons.numbers, CounterPage(), 'Counter Field'),
  PageInfo(Icons.date_range, DateFieldPage(), 'Date Field'),
  PageInfo(Icons.dialpad_outlined, DialogsPage(), 'Dialogs'),
  PageInfo(Icons.space_bar, DividerPage(), 'Dividers'),
  PageInfo(Icons.arrow_drop_down, DropdownFieldPage(), 'Dropdown Field'),
  PageInfo(Icons.link, LinkPage(), 'Links'),
  PageInfo(Icons.list, ListViewPage(), 'List View'),
  PageInfo(Icons.landscape, OrientationPage(), 'Orientation'),
  PageInfo(Icons.price_check, PicklistPage(), 'Picklists'),
  PageInfo(Icons.business, PlaceholderPage(), 'Placeholders'),
  PageInfo(Icons.phonelink_setup_sharp, PopupMenuPage(), 'Popup Menu'),
  PageInfo(Icons.radio, RadioPage(), 'Radios'),
  PageInfo(Icons.star, RatingPage(), 'Rating Bar'),
  PageInfo(Icons.search, SearchBarPage(), 'Search Bar'),
  PageInfo(Icons.scale, ScaffoldPage(), 'Scaffold'),
  PageInfo(Icons.tune, SliderPage(), 'Sliders'),
  PageInfo(Icons.grid_4x4, SliverGridPage(), 'Sliver Grid'),
  PageInfo(Icons.list, SliverListPage(), 'Sliver List'),
  PageInfo(Icons.timelapse, TimeFieldPage(), 'Time Field'),
];
