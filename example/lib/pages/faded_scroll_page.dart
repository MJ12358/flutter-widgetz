import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class FadedScrollPage extends StatelessWidget {
  const FadedScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Horizontal'),
                Tab(text: 'Vertical'),
                Tab(text: 'Updatable'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _Horizontal(),
            _Vertical(),
            _Updatable(),
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
          child: FadedScroll(
            axis: Axis.horizontal,
            // This is necessary to give the ListView a controller
            // as horizontal ListViews don't automatically get a controller.
            child: Builder(
              builder: (BuildContext context) {
                return ListView.separated(
                  controller: PrimaryScrollController.of(context),
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
                );
              },
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
    return FadedScroll(
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

class _Updatable extends StatefulWidget {
  const _Updatable();

  @override
  State<_Updatable> createState() => _UpdatableState();
}

class _UpdatableState extends State<_Updatable> {
  int itemCount = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            child: const Text('Add Item'),
            onPressed: () => setState(() {
              itemCount++;
            }),
          ),
        ),
        Expanded(
          child: FadedScroll(
            child: ListView.separated(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Title $index'),
                  subtitle: Text('Subtitle $index'),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ),
      ],
    );
  }
}
