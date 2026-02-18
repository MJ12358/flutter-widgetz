import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class FadedScrollablePage extends StatelessWidget {
  const FadedScrollablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Horizontal'),
                Tab(text: 'Vertical'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _Horizontal(),
            _Vertical(),
          ],
        ),
      ),
    );
  }
}

class _Horizontal extends StatelessWidget {
  const _Horizontal();

  @override
  Widget build(BuildContext context) {
    final double height = Theme.of(context).listTileTheme.minTileHeight ?? 72.0;

    return Column(
      children: <Widget>[
        SizedBox(
          height: height,
          child: FadedScrollable(
            axis: Axis.horizontal,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 100,
                  height: height,
                  child: ListTile(
                    title: Text('Title $index'),
                    subtitle: Text('Subtitle $index'),
                  ),
                );
              },
              separatorBuilder: (_, __) => const VerticalDivider(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Vertical extends StatelessWidget {
  const _Vertical();

  @override
  Widget build(BuildContext context) {
    return FadedScrollable(
      child: ListView.separated(
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Title $index'),
            subtitle: Text('Subtitle $index'),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
