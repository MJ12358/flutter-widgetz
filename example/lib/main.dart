import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_themez/flutter_themez.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';
import 'package:flutter_widgetz_example/pages/accordion_page.dart';
import 'package:flutter_widgetz_example/pages/alert_page.dart';
import 'package:flutter_widgetz_example/pages/auth_button_page.dart';
import 'package:flutter_widgetz_example/pages/avatar_page.dart';
import 'package:flutter_widgetz_example/pages/badge_page.dart';
import 'package:flutter_widgetz_example/pages/button_page.dart';
import 'package:flutter_widgetz_example/pages/carousel_page.dart';
import 'package:flutter_widgetz_example/pages/checkbox_page.dart';
import 'package:flutter_widgetz_example/pages/color_picker_page.dart';
import 'package:flutter_widgetz_example/pages/countdown_page.dart';
import 'package:flutter_widgetz_example/pages/counter_field_page.dart';
import 'package:flutter_widgetz_example/pages/date_field_page.dart';
import 'package:flutter_widgetz_example/pages/dialogs_page.dart';
import 'package:flutter_widgetz_example/pages/directional_pad_page.dart';
import 'package:flutter_widgetz_example/pages/divider_page.dart';
import 'package:flutter_widgetz_example/pages/dropdown_field_page.dart';
import 'package:flutter_widgetz_example/pages/duration_picker_page.dart';
import 'package:flutter_widgetz_example/pages/feedback_page.dart';
import 'package:flutter_widgetz_example/pages/grouped_list_view_page.dart';
import 'package:flutter_widgetz_example/pages/image_page.dart';
import 'package:flutter_widgetz_example/pages/link_page.dart';
import 'package:flutter_widgetz_example/pages/list_view_page.dart';
import 'package:flutter_widgetz_example/pages/marquee_page.dart';
import 'package:flutter_widgetz_example/pages/navigation_rail_page.dart';
import 'package:flutter_widgetz_example/pages/orienatation_page.dart';
import 'package:flutter_widgetz_example/pages/picklist_page.dart';
import 'package:flutter_widgetz_example/pages/placeholder_page.dart';
import 'package:flutter_widgetz_example/pages/poll_page.dart';
import 'package:flutter_widgetz_example/pages/popup_menu_page.dart';
import 'package:flutter_widgetz_example/pages/progress_indicator_page.dart';
import 'package:flutter_widgetz_example/pages/radio_page.dart';
import 'package:flutter_widgetz_example/pages/rating_page.dart';
import 'package:flutter_widgetz_example/pages/scaffold_page.dart';
import 'package:flutter_widgetz_example/pages/search_bar_page.dart';
import 'package:flutter_widgetz_example/pages/settings_page.dart';
import 'package:flutter_widgetz_example/pages/shimmer_page.dart';
import 'package:flutter_widgetz_example/pages/slider_page.dart';
import 'package:flutter_widgetz_example/pages/sliver_grid_page.dart';
import 'package:flutter_widgetz_example/pages/sliver_list_page.dart';
import 'package:flutter_widgetz_example/pages/text_field_page.dart';
import 'package:flutter_widgetz_example/pages/text_page.dart';
import 'package:flutter_widgetz_example/pages/time_field_page.dart';
import 'package:flutter_widgetz_example/pages/welcome_page.dart';

/// To run the example app, clone/fork the repo!
/// You'll need to change the pubspec.yaml file to point to remote

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
  late Page _currentPage;
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
      restorationScopeId: 'root',
      home: CustomScaffold(
        // TODO: this has an odd effect when using an ExpandableFab
        dynamicFab: true,
        floatingActionButton: ExpandableFab(
          children: <Widget>[
            const _TimeDilationButton(),
            ExpandedActionButton(
              icon: const Icon(Icons.grid_3x3),
              onPressed: _onShowMaterialGrid,
            ),
            ExpandedActionButton(
              icon: Icon(_isDark ? Icons.dark_mode : Icons.sunny),
              onPressed: _onDarkModeChanged,
            ),
          ],
        ),
        appBar: CustomAppBar.subtitled(
          title: const Text('Flutter Widgetz'),
          subtitle: Text(_currentPage.title),
        ),
        drawer: CustomDrawer.builder(
          header: const Text('Flutter Widgetz!'),
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
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
            ),
          ],
        ),
        body: Scaffold(
          body: PageView.builder(
            clipBehavior: Clip.none,
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index].page;
            },
          ),
        ),
      ),
      theme: _isDark ? _theme.dark() : _theme.light(),
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

class _TimeDilationButton extends StatelessWidget {
  const _TimeDilationButton();

  @override
  Widget build(BuildContext context) {
    return ExpandedActionButton(
      icon: const Icon(Icons.timelapse),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => SimpleDialog(
          title: const Text('Time Dilation'),
          children: <Widget>[
            CustomSlider(
              min: 1,
              max: 10,
              divisions: 9,
              value: timeDilation,
              onChanged: (num value) => timeDilation = value.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}

class Page {
  const Page(
    this.icon,
    this.page,
    this.title,
  );

  final IconData icon;
  final Widget page;
  final String title;
}

const List<Page> _pages = <Page>[
  Page(Icons.account_tree, AccordionPage(), 'Accordions'),
  Page(Icons.notifications, AlertPage(), 'Alerts'),
  Page(Icons.login, AuthButtonPage(), 'Auth Buttons'),
  Page(Icons.person, AvatarPage(), 'Avatars'),
  Page(Icons.badge, BadgePage(), 'Badges'),
  Page(Icons.gamepad, ButtonPage(), 'Buttons'),
  Page(Icons.roundabout_left, CarouselPage(), 'Carousel'),
  Page(Icons.check_box, CheckboxPage(), 'Checkboxes'),
  Page(Icons.color_lens, ColorPickerPage(), 'Color Picker'),
  Page(Icons.downhill_skiing, CountdownPage(), 'Countdown'),
  Page(Icons.numbers, CounterPage(), 'Counter Field'),
  Page(Icons.date_range, DateFieldPage(), 'Date Field'),
  Page(Icons.dialpad_outlined, DialogsPage(), 'Dialogs'),
  Page(Icons.directions, DirectionalPadPage(), 'Directional Pad'),
  Page(Icons.space_bar, DividerPage(), 'Dividers'),
  Page(Icons.arrow_drop_down, DropdownFieldPage(), 'Dropdown Field'),
  Page(Icons.timelapse, DurationFieldPage(), 'Duration Picker'),
  Page(Icons.feedback, FeedbackPage(), 'Feedback'),
  Page(Icons.group, GroupedListViewPage(), 'Grouped List'),
  Page(Icons.image, ImagePage(), 'Images'),
  Page(Icons.link, LinkPage(), 'Links'),
  Page(Icons.list, ListViewPage(), 'List View'),
  Page(Icons.margin, MarqueePage(), 'Marquee'),
  Page(Icons.navigation, NavigationRailPage(), 'Navigation Rail'),
  Page(Icons.landscape, OrientationPage(), 'Orientation'),
  Page(Icons.percent, ProgressIndicatorPage(), 'Progress'),
  Page(Icons.price_check, PicklistPage(), 'Picklists'),
  Page(Icons.business, PlaceholderPage(), 'Placeholders'),
  Page(Icons.poll, PollPage(), 'Polls'),
  Page(Icons.phonelink_setup_sharp, PopupMenuPage(), 'Popup Menu'),
  Page(Icons.radio, RadioPage(), 'Radios'),
  Page(Icons.settings, SettingsPage(), 'Settings'),
  Page(Icons.star, RatingPage(), 'Ratings'),
  Page(Icons.scale, ScaffoldPage(), 'Scaffold'),
  Page(Icons.search, SearchBarPage(), 'Search Bar'),
  Page(Icons.shield, ShimmerPage(), 'Shimmer'),
  Page(Icons.tune, SliderPage(), 'Sliders'),
  Page(Icons.grid_4x4, SliverGridPage(), 'Sliver Grid'),
  Page(Icons.list, SliverListPage(), 'Sliver List'),
  Page(Icons.text_format, TextPage(), 'Text'),
  Page(Icons.text_fields, TextFieldPage(), 'Text Field'),
  Page(Icons.timelapse, TimeFieldPage(), 'Time Field'),
  Page(Icons.web_outlined, WelcomePage(), 'Welcome'),
];
