import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  List<Object> get _images => <Object>[
        'assets/images/test.png',
        'assets/images/test2.png',
        Uint8List(0),
        _placeholder,
        'https://placehold.co/200/png',
        'https://placehold.co/400/png',
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

  Widget _getImage(Object o) {
    if (o is String) {
      if (o.contains('http')) {
        return CustomImage.network(o);
      } else {
        return CustomImage.asset(o);
      }
    }
    if (o is Uint8List) {
      return CustomImage.memory(o);
    }
    return const SizedBox();
  }
}

/// From ChatGPT (should be white)
Uint8List get _placeholder {
  // Define the dimensions of the image
  const int width = 100;
  const int height = 100;
  // Calculate the image size and create a Uint8List to hold the image data
  const int imageSize = width * height * 3; // Each pixel has 3 bytes (RGB)
  final Uint8List image = Uint8List(54 + imageSize); // BMP header is 54 bytes
  // BMP header (14 bytes) - BitmapFileHeader
  image[0] = 0x42; // 'B'
  image[1] = 0x4D; // 'M'
  image[2] = imageSize & 0xFF;
  image[3] = (imageSize >> 8) & 0xFF;
  image[4] = (imageSize >> 16) & 0xFF;
  image[5] = (imageSize >> 24) & 0xFF;
  image[10] = 54; // Offset to pixel data
  // DIB header (40 bytes) - BitmapInfoHeader
  image[14] = 40; // DIB header size
  image[18] = width & 0xFF;
  image[19] = (width >> 8) & 0xFF;
  image[20] = (width >> 16) & 0xFF;
  image[22] = height & 0xFF;
  image[23] = (height >> 8) & 0xFF;
  image[24] = (height >> 16) & 0xFF;
  image[26] = 1; // Number of color planes
  image[28] = 24; // Bits per pixel
  // Fill the image with a white color (RGB)
  for (int i = 54; i < image.length; i += 3) {
    image.fillRange(i, i + 3, 255);
  }
  return image;
}
