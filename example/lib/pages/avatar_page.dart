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
          const CustomDivider(child: Text('Flutter Defaults')),
          const CircleAvatar(),
          const CircleAvatar(
            child: Icon(Icons.abc),
          ),
          const CustomDivider(child: Text('Custom')),
          const CustomAvatar(),
          const CustomAvatar(
            icon: Icon(Icons.abc),
          ),
          CustomAvatar.network(
            'notavalidurl',
            icon: const Icon(Icons.disabled_by_default),
          ),
          CustomAvatar.network(
            'https://example.com',
            icon: const Icon(Icons.disabled_by_default),
          ),
          AvatarGroup(),
          CustomAvatar.network(
            'https://loremflickr.com/640/360',
            radius: 50,
          ),
          AvatarGroup.network(
            'https://loremflickr.com/640/360',
            radius: 50,
          ),
        ],
      ),
    );
  }
}
