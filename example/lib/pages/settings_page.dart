import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: <Widget>[
        SettingsSection(
          title: 'Section #1',
          tiles: <Widget>[
            const SettingsTile(
              title: Text('Link'),
              leading: Icon(Icons.link),
              trailing: Icon(Icons.exit_to_app),
            ),
            SettingsTile.darkMode(
              title: const Text('Dark Mode'),
              value: false,
              onChanged: print,
            ),
            SettingsTile.switched(
              title: const Text('Switch'),
              leading: const Icon(Icons.dark_mode),
              value: true,
              onChanged: print,
            ),
            SettingsTile.colorPicker(
              context: context,
              color: Colors.purple,
              defaultColor: Colors.orange,
              onChanged: print,
              title: const Text('Color Picker'),
            ),
          ],
        ),
        SettingsSection(
          title: 'Section #2',
          tiles: <Widget>[
            const SettingsTile(
              title: Text('Check'),
              leading: Icon(Icons.checklist),
              trailing: Icon(Icons.check),
            ),
            const SettingsTile(
              title: Text('Chevron'),
              leading: Icon(Icons.event),
              trailing: Icon(Icons.chevron_right),
            ),
            SettingsTile.switched(
              title: const Text('Switch'),
              leading: const Icon(Icons.theater_comedy),
              value: true,
              onChanged: print,
            ),
            SettingsTile.switched(
              title: const Text('Switch'),
              leading: const Icon(Icons.collections_sharp),
              value: true,
              onChanged: print,
            ),
          ],
        ),
        SettingsSection(
          title: 'Section #3',
          tiles: <Widget>[
            const SettingsTile(
              title: Text('Link'),
              trailing: Icon(Icons.exit_to_app),
            ),
            const SettingsTile(
              title: Text('Link'),
              trailing: Icon(Icons.exit_to_app),
            ),
            SettingsTile.switched(
              title: const Text('Switch'),
              value: true,
              onChanged: print,
            ),
            SettingsTile.switched(
              title: const Text('Switch'),
              value: true,
              onChanged: print,
            ),
          ],
        ),
      ],
    );
  }
}
