import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({
    super.key,
    required this.onDarkModeChanged,
    required this.onShowMaterialGrid,
  });

  final VoidCallback onDarkModeChanged;
  final VoidCallback onShowMaterialGrid;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: <Widget>[
        SettingsTile.switched(
          title: const Text('Toggle Dark Mode'),
          leading: const Icon(Icons.dark_mode),
          value: false,
          onChanged: (_) => widget.onDarkModeChanged(),
        ),
        SettingsTile.switched(
          title: const Text('Show Material Grid'),
          leading: const Icon(Icons.grid_3x3),
          value: false,
          onChanged: (_) => widget.onShowMaterialGrid(),
        ),
        SettingsTile.timeDilation(
          context: context,
          title: const Text('Set Time Dilation'),
        ),
      ],
    );
  }
}
