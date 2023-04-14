import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomSingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: CustomAvatar(
        networkImage: 'https://loremflickr.com/640/360',
        radius: 50,
      ),
    );
  }
}
