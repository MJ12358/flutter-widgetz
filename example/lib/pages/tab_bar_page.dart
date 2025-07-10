import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: CustomScaffold(
        appBar: CustomAppBar(
          bottom: CustomTabBar(
            tabs: const <Widget>[
              Tab(child: Text('1')),
              Tab(child: Text('2')),
              Tab(child: Text('3')),
              Tab(child: Text('4')),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Text('1'),
            Text('2'),
            Text('3'),
            Text('4'),
          ],
        ),
      ),
    );
  }
}
