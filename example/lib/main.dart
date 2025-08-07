import 'package:flutter/material.dart' hide Page;
import 'package:flutter_themez/flutter_themez.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';
import 'package:flutter_widgetz_example/home.dart';
import 'package:flutter_widgetz_example/page.dart';
import 'package:flutter_widgetz_example/settings.dart';

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
  late final PageController _pageController;
  late final PageController _viewController;
  late Page _currentPage;
  late bool _isDark;
  late bool _showMaterialGrid;
  late FlutterThemez _theme;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _viewController = PageController();
    _currentPage = pages[0];
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
            ExpandedActionButton(
              icon: const Icon(Icons.one_k),
              onPressed: () {},
            ),
            ExpandedActionButton(
              icon: const Icon(Icons.two_k),
              onPressed: () {},
            ),
            ExpandedActionButton(
              icon: const Icon(Icons.three_k),
              onPressed: () {},
            ),
          ],
        ),
        appBar: CustomAppBar.subtitled(
          title: const Text('Flutter Widgetz'),
          subtitle: Text(_currentPage.title),
        ),
        drawer: CustomDrawer.builder(
          header: const Text('Flutter Widgetz!'),
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(pages[index].icon),
              title: Text(pages[index].title),
              onTap: () => _onDrawerChanged(context, index),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          onTap: _onViewChanged,
          items: const <BottomNavigationBarItem>[
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
          body: PageView(
            clipBehavior: Clip.none,
            controller: _viewController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onViewChanged,
            children: <Widget>[
              HomeView(
                onPageChanged: _onPageChanged,
                controller: _pageController,
              ),
              SettingsView(
                onDarkModeChanged: _onDarkModeChanged,
                onShowMaterialGrid: _onShowMaterialGrid,
              ),
            ],
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
    _pageController.jumpToPage(index);
    // Close the drawer
    Navigator.pop(context);
    // Jump bottom navigation bar to the first page
    _viewController.jumpToPage(0);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = pages[index];
    });
  }

  void _onViewChanged(int index) {
    _viewController.jumpToPage(index);
  }
}
