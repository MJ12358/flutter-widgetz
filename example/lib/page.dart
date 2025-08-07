import 'package:flutter/material.dart';
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
import 'package:flutter_widgetz_example/pages/tab_bar_page.dart';
import 'package:flutter_widgetz_example/pages/text_field_page.dart';
import 'package:flutter_widgetz_example/pages/text_page.dart';
import 'package:flutter_widgetz_example/pages/time_field_page.dart';
import 'package:flutter_widgetz_example/pages/welcome_page.dart';

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

final List<Page> pages = <Page>[
  const Page(Icons.account_tree, AccordionPage(), 'Accordions'),
  const Page(Icons.notifications, AlertPage(), 'Alerts'),
  const Page(Icons.login, AuthButtonPage(), 'Auth Buttons'),
  const Page(Icons.person, AvatarPage(), 'Avatars'),
  const Page(Icons.badge, BadgePage(), 'Badges'),
  const Page(Icons.gamepad, ButtonPage(), 'Buttons'),
  const Page(Icons.roundabout_left, CarouselPage(), 'Carousel'),
  const Page(Icons.check_box, CheckboxPage(), 'Checkboxes'),
  const Page(Icons.color_lens, ColorPickerPage(), 'Color Picker'),
  const Page(Icons.downhill_skiing, CountdownPage(), 'Countdown'),
  const Page(Icons.numbers, CounterPage(), 'Counter Field'),
  const Page(Icons.date_range, DateFieldPage(), 'Date Field'),
  const Page(Icons.dialpad_outlined, DialogsPage(), 'Dialogs'),
  const Page(Icons.directions, DirectionalPadPage(), 'Directional Pad'),
  const Page(Icons.space_bar, DividerPage(), 'Dividers'),
  const Page(Icons.arrow_drop_down, DropdownFieldPage(), 'Dropdown Field'),
  const Page(Icons.timelapse, DurationFieldPage(), 'Duration Picker'),
  const Page(Icons.feedback, FeedbackPage(), 'Feedback'),
  const Page(Icons.group, GroupedListViewPage(), 'Grouped List'),
  const Page(Icons.image, ImagePage(), 'Images'),
  const Page(Icons.link, LinkPage(), 'Links'),
  const Page(Icons.list, ListViewPage(), 'List View'),
  const Page(Icons.margin, MarqueePage(), 'Marquee'),
  const Page(Icons.navigation, NavigationRailPage(), 'Navigation Rail'),
  const Page(Icons.landscape, OrientationPage(), 'Orientation'),
  const Page(Icons.percent, ProgressIndicatorPage(), 'Progress'),
  const Page(Icons.price_check, PicklistPage(), 'Picklists'),
  const Page(Icons.business, PlaceholderPage(), 'Placeholders'),
  const Page(Icons.poll, PollPage(), 'Polls'),
  const Page(Icons.phonelink_setup_sharp, PopupMenuPage(), 'Popup Menu'),
  const Page(Icons.radio, RadioPage(), 'Radios'),
  const Page(Icons.settings, SettingsPage(), 'Settings'),
  const Page(Icons.star, RatingPage(), 'Ratings'),
  const Page(Icons.scale, ScaffoldPage(), 'Scaffold'),
  const Page(Icons.search, SearchBarPage(), 'Search Bar'),
  const Page(Icons.shield, ShimmerPage(), 'Shimmer'),
  const Page(Icons.tune, SliderPage(), 'Sliders'),
  const Page(Icons.grid_4x4, SliverGridPage(), 'Sliver Grid'),
  const Page(Icons.list, SliverListPage(), 'Sliver List'),
  const Page(Icons.tab, TabBarPage(), 'Tab Bar'),
  const Page(Icons.text_format, TextPage(), 'Text'),
  const Page(Icons.text_fields, TextFieldPage(), 'Text Field'),
  const Page(Icons.timelapse, TimeFieldPage(), 'Time Field'),
  const Page(Icons.web_outlined, WelcomePage(), 'Welcome'),
];
