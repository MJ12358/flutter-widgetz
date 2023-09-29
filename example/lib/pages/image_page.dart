import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  List<_ImageInfo> get _images => <_ImageInfo>[
        _ImageInfo('assets/images/placeholder.png', Colors.amber),
        _ImageInfo('assets/images/test.png', Colors.amber),
        _ImageInfo('assets/images/derp.png', Colors.amber),
        _ImageInfo(Uint8List(0), Colors.blue),
        _ImageInfo(Uint8List(99), Colors.blue),
        _ImageInfo(null, Colors.blue),
        _ImageInfo('https://placehold.co/200/png', Colors.green),
        _ImageInfo('https://placehold.co/400/png', Colors.green),
        _ImageInfo('http://example.com', Colors.green),
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

  Widget _getImage(_ImageInfo info) {
    return CustomImage.dynamic(
      info.image,
      color: info.color,
      errorWidget: Image.asset('assets/images/error.png'),
    );
  }
}

class _ImageInfo {
  _ImageInfo(
    this.image,
    this.color,
  );

  final Object? image;
  final Color? color;
}
