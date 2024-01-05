import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  late final List<Widget> _items;
  late final List<Widget> _colors;

  @override
  void initState() {
    super.initState();
    _items = List<Widget>.generate(5, (int i) {
      return Center(child: Text('$i'));
    });
    _colors = Colors.primaries
        .map(
          (MaterialColor e) => Container(color: e),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        spacer: const SizedBox(height: 16.0),
        children: <Widget>[
          const CustomDivider(child: Text('Count')),
          SizedBox(
            height: 100,
            width: 100,
            child: Carousel.count(
              autoplay: true,
              onChanged: print,
              children: _items,
            ),
          ),
          const CustomDivider(child: Text('Builder (default)')),
          SizedBox(
            height: 100,
            width: 200,
            child: Carousel.builder(
              autoplay: true,
              itemCount: _colors.length,
              itemBuilder: (_, int index) {
                return _colors[index];
              },
              onChanged: print,
            ),
          ),
          const CustomDivider(child: Text('Builder (custom)')),
          SizedBox(
            height: 100,
            width: 200,
            child: Carousel.builder(
              autoplay: true,
              itemCount: _colors.length,
              itemBuilder: (_, int index) {
                return _colors[index];
              },
              onChanged: print,
              pageDuration: const Duration(seconds: 3),
              scrollDirection: Axis.vertical,
              transitionDuration: const Duration(milliseconds: 500),
            ),
          ),
        ],
      ),
    );
  }
}
