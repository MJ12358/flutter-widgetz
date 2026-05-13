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
    return SettingsList(
      sections: <Widget>[
        SettingsSection(
          title: 'General',
          tiles: <Widget>[
            SettingsTile.switched(
              title: const Text('Toggle Dark Mode'),
              leading: const Icon(Icons.dark_mode),
              value: false,
              onChanged: (_) => widget.onDarkModeChanged(),
            ),
          ],
        ),
        SettingsSection(
          title: 'Developer',
          tiles: <Widget>[
            SettingsTile.switched(
              title: const Text('Show Material Grid'),
              leading: const Icon(Icons.grid_3x3),
              value: false,
              onChanged: (_) => widget.onShowMaterialGrid(),
            ),
            SettingsTile.timeDilation(
              context: context,
              title: const Text('Set Time Dilation'),
              onChanged: print,
            ),
          ],
        ),
        SettingsSection(
          title: 'Testing',
          tiles: <Widget>[
            ...List<Widget>.generate(10, (int index) {
              return SettingsTile(
                title: Text('Item $index'),
                leading: const Icon(Icons.settings),
              );
            }),
          ],
        ),
      ],
    );
  }
}
