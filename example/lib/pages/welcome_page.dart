// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Welcome(
      onCompleted: () => print('onCompleted'),
      pages: const <Widget>[
        WelcomeContent(
          asset: 'assets/images/placeholder.png',
          title: 'Title1',
          description: 'Description1',
        ),
        WelcomeContent(
          asset: 'assets/images/placeholder.png',
          title: 'Title2',
          description: 'Description2',
        ),
        WelcomeContent(
          asset: 'assets/images/placeholder.png',
          title: 'Title3',
          description: 'Description3',
        ),
      ],
    );
  }
}
