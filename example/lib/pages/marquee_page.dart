import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class MarqueePage extends StatelessWidget {
  const MarqueePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(36.0),
      child: Marquee(
        child: Text(
          'Some very long text that will need to be scrolled across the page. '
          'Oh, hi Mark!',
        ),
      ),
    );
  }
}
