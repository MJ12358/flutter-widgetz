import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class NavigationRailPage extends StatefulWidget {
  const NavigationRailPage({super.key});

  @override
  State<NavigationRailPage> createState() => _NavigationRailPageState();
}

class _NavigationRailPageState extends State<NavigationRailPage> {
  int _index = 0;

  static const List<NavigationRailDestination> _destinations =
      <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          label: Text('Home'),
          selectedIcon: Icon(Icons.home),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          label: Text('Favorites'),
          selectedIcon: Icon(Icons.star),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline),
          label: Text('Account'),
          selectedIcon: Icon(Icons.person),
        ),
      ];

  static const List<Widget> _pages = <Widget>[
    ColoredBox(
      color: Colors.amber,
      child: Text('One'),
    ),
    ColoredBox(
      color: Colors.purple,
      child: Text('Two'),
    ),
    ColoredBox(
      color: Colors.teal,
      child: Text('Three'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomNavigationRail(
          destinations: _destinations,
          labelType: NavigationRailLabelType.all,
          onDestinationSelected: _onTap,
          leading: const Text('Leading'),
          trailing: const Text('Trailing'),
          useIndicator: true,
        ),
        const VerticalDivider(),
        Expanded(
          child: _pages[_index],
        ),
      ],
    );
  }

  void _onTap(int value) {
    setState(() {
      _index = value;
    });
  }
}
