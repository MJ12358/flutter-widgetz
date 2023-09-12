import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  List<Object?> get _images => <Object?>[
        'assets/images/test.png',
        'assets/images/test2.png',
        'assets/images/derp.png',
        Uint8List(0),
        Uint8List(99),
        null,
        'https://placehold.co/200/png',
        'https://placehold.co/400/png',
        'http://example.com',
      ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _images.length,
      itemBuilder: (_, int index) {
        return _getImage(_images[index]);
      },
    );
  }

  Widget _getImage(Object? o) {
    if (o is String) {
      if (o.contains('http')) {
        return CustomImage.network(o);
      } else {
        return CustomImage.asset(o);
      }
    }
    if (o is Uint8List || o == null) {
      return CustomImage.memory(
        o as Uint8List?,
        color: Colors.blue,
      );
    }
    return const SizedBox();
  }
}
