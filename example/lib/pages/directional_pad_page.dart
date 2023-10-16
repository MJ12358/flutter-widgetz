import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class DirectionalPadPage extends StatelessWidget {
  const DirectionalPadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          DirectionalPad.arrow(
            onTap: print,
          ),
          DirectionalPad.chevron(
            onTap: print,
          ),
          DirectionalPad.arrow(
            size: 128,
            backgroundColor: Colors.black,
            buttonColor: Colors.purple,
            onTap: print,
            shape: BoxShape.rectangle,
          ),
          DirectionalPad.classic(
            onTap: print,
            size: 150,
          ),
          DirectionalPad.playstation(
            onTap: print,
            size: 150,
          ),
          DirectionalPad.xbox(
            onTap: print,
            size: 150,
          ),
          DirectionalPad(
            buttons: const <Widget>[
              Icon(Icons.abc),
              Icon(Icons.ac_unit),
              Icon(Icons.back_hand),
              Icon(Icons.cabin),
            ],
          ),
        ],
      ),
    );
  }
}
