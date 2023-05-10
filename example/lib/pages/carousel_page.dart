import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({Key? key}) : super(key: key);

  List<Widget> get _items {
    return List<Widget>.generate(5, (int i) {
      return Center(child: Text('$i'));
    });
  }

  List<Widget> get _colors {
    return Colors.primaries
        .map(
          (MaterialColor e) => Container(
            color: e,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Carousel.count(
              autoplay: true,
              onChanged: print,
              children: _items,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: SizedBox(
            height: 100,
            width: 200,
            child: Carousel.builder(
              autoplay: true,
              itemCount: _colors.length,
              itemBuilder: (BuildContext context, int index) {
                return _colors[index];
              },
              onChanged: print,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: SizedBox(
            height: 100,
            width: 200,
            child: Carousel.builder(
              autoplay: true,
              itemCount: _colors.length,
              itemBuilder: (BuildContext context, int index) {
                return _colors.reversed.toList()[index];
              },
              onChanged: print,
              pageDuration: const Duration(seconds: 3),
              scrollDirection: Axis.vertical,
              transitionDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      ],
    );
  }
}
