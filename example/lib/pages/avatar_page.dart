import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const CircleAvatar(
            child: Icon(Icons.abc),
          ),
          const CustomAvatar(),
          const CustomAvatar(
            icon: Icons.abc,
          ),
          CustomAvatar.network(
            'notavalidurl',
            icon: Icons.disabled_by_default,
          ),
          CustomAvatar.network(
            'https://example.com',
            icon: Icons.disabled_by_default,
          ),
          CustomAvatar.network(
            'https://loremflickr.com/640/360',
            radius: 50,
          ),
          AvatarGroup.network(
            'https://loremflickr.com/640/360',
            radius: 50,
          ),
          AvatarGroup(),
        ],
      ),
    );
  }
}
