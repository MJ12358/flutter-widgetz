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
            SettingsTile.darkMode(
              value: false,
              onChanged: print,
            ),
            SettingsTile.switched(
              title: const Text('Switch'),
              leading: const Icon(Icons.switch_access_shortcut),
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
            SettingsTile.immersiveMode(
              value: false,
              onChanged: print,
            ),
            const _Orientation(),
            const _TimeDilation(),
            SettingsTile.licenses(context: context),
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

class _Orientation extends StatefulWidget {
  const _Orientation();

  @override
  State<_Orientation> createState() => __OrientationState();
}

class __OrientationState extends State<_Orientation> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return SettingsTile.orientation(
      context: context,
      onChanged: (bool value) {
        setState(() {
          _value = value;
        });
      },
      value: _value,
    );
  }
}

class _TimeDilation extends StatefulWidget {
  const _TimeDilation();

  @override
  State<_TimeDilation> createState() => __TimeDilationState();
}

class __TimeDilationState extends State<_TimeDilation> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return SettingsTile.timeDilation(
      context: context,
      value: _value.toDouble(),
      onChanged: (double value) {
        setState(() {
          _value = value.toInt();
        });
      },
    );
  }
}
