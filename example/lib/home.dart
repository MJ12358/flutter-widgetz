import 'package:flutter/material.dart';
import 'package:flutter_widgetz_example/page.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.onPageChanged,
    required this.controller,
  });

  final ValueChanged<int> onPageChanged;
  final PageController controller;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      clipBehavior: Clip.none,
      controller: widget.controller,
      onPageChanged: widget.onPageChanged,
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return pages[index].page;
      },
    );
  }
}
