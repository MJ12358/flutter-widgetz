import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class StaggeredDisplayPage extends StatelessWidget {
  const StaggeredDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const StaggeredDisplay(
        children: <Widget>[
          Text('Staggered One'),
          Text('Staggered Two'),
          Text('Staggered Three'),
          Text('Staggered Four'),
          Text('Staggered Five'),
        ],
      ),
    );
  }
}
