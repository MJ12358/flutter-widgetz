part of flutter_widgetz;

/// {@template flutter_widgetz.SettingsList}
/// A list of [SettingsSection].
/// {@endtemplate}
class SettingsList extends StatelessWidget {
  /// {@macro flutter_widgetz.SettingsList}
  const SettingsList({
    super.key,
    required this.sections,
    this.clipBehavior = Clip.hardEdge,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  /// A list of widgets to use as the sections.
  /// Usually a list of [SettingsSection].
  final List<Widget> sections;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// The amount of space to surround the child.
  final EdgeInsets? padding;

  /// How the page view should respond to user input.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view should be
  /// determined by the contents being viewed.
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: clipBehavior,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: sections.length,
      itemBuilder: (_, int index) {
        return sections[index];
      },
    );
  }
}

/// {@template flutter_widgetz.SettingsSection}
/// A section of [SettingsTile]'s.
/// {@endtemplate}
class SettingsSection extends StatelessWidget {
  /// {@macro flutter_widgetz.SettingsSection}
  const SettingsSection({
    super.key,
    required this.tiles,
    required this.title,
    this.padding = const EdgeInsets.all(20.0),
  });

  /// A list of widgets to use as the tiles.
  /// Usually a list of [SettingsTile] or [ListTile].
  final List<Widget> tiles;

  /// The title of this section.
  final String title;

  /// The amount of space to surround the child.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: padding,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        ListView.separated(
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tiles.length,
          itemBuilder: (_, int index) {
            return tiles[index];
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
        ),
      ],
    );
  }
}

/// {@template flutter_widgetz.SettingsTile}
/// A settings tile.
/// {@endtemplate}
class SettingsTile extends StatelessWidget {
  /// {@macro flutter_widgetz.SettingsTile}
  const SettingsTile({
    super.key,
    required this.title,
    this.enabled = _defaultEnabled,
    this.leading,
    this.onTap,
    this.subtitle,
    this.trailing,
  });

  /// The primary content of the list tile.
  final Widget title;

  /// Whether this list tile is interactive.
  final bool enabled;

  /// A widget to display before the title.
  final Widget? leading;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display after the title.
  final Widget? trailing;

  static const bool _defaultEnabled = true;

  static Future<void> _showBottomSheet({
    required BuildContext context,
    required Widget widget,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return widget;
      },
    );
  }

  static void _setImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  static void _unsetImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// DarkMode uses a [Switch] as the trailing widget
  /// and alternates between dark_mode and light_mode icons.
  SettingsTile.darkMode({
    super.key,
    required ValueChanged<bool> onChanged,
    required bool value,
    this.enabled = _defaultEnabled,
    Widget? leading,
    this.subtitle,
    this.title = const Text('Dark Mode'),
  })  : onTap = null,
        leading = leading ?? Icon(value ? Icons.dark_mode : Icons.light_mode),
        trailing = Switch(
          value: value,
          onChanged: onChanged,
        );

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// ImmersiveMode uses a [Switch] as the trailing widget
  /// and alternates between fullscreen_exit and fullscreen icons,
  /// while setting [SystemUiMode].
  SettingsTile.immersiveMode({
    super.key,
    required ValueChanged<bool> onChanged,
    required bool value,
    this.enabled = _defaultEnabled,
    Widget? leading,
    this.subtitle,
    this.title = const Text('Immersive Mode'),
  })  : onTap = null,
        leading =
            leading ?? Icon(value ? Icons.fullscreen : Icons.fullscreen_exit),
        trailing = Switch(
          value: value,
          onChanged: (bool value) {
            onChanged.call(value);
            value ? _setImmersiveMode() : _unsetImmersiveMode();
          },
        ) {
    // set default mode based on the input value
    if (value) {
      _setImmersiveMode();
    } else {
      _unsetImmersiveMode();
    }
  }

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// Licenses utilizes [showLicensePage] when tapped.
  SettingsTile.licenses({
    super.key,
    required BuildContext context,
    String? applicationName,
    String? applicationVersion,
    Widget? applicationIcon,
    String? applicationLegalese,
    this.enabled = _defaultEnabled,
    Widget? leading,
    this.subtitle,
    this.title = const Text('Licenses'),
    this.trailing,
  })  : onTap = (() => showLicensePage(
              context: context,
              applicationName: applicationName,
              applicationVersion: applicationVersion,
              applicationIcon: applicationIcon,
              applicationLegalese: applicationLegalese,
            )),
        leading = leading ?? const Icon(Icons.policy);

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// Switched uses a [Switch] as the trailing widget.
  SettingsTile.switched({
    super.key,
    required ValueChanged<bool> onChanged,
    required this.title,
    required bool value,
    this.enabled = _defaultEnabled,
    this.leading,
    this.subtitle,
  })  : onTap = null,
        trailing = Switch(
          value: value,
          onChanged: onChanged,
        );

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// TimeDilation shows a simple dialog that changes [timeDilation].
  SettingsTile.timeDilation({
    super.key,
    required BuildContext context,
    this.enabled = _defaultEnabled,
    Widget? leading,
    this.subtitle,
    this.title = const Text('Time Dilation'),
    this.trailing,
    double? value,
  })  : leading = leading ?? const Icon(Icons.timelapse),
        onTap = (() => showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                title: title,
                children: <Widget>[
                  CustomSlider(
                    min: 1,
                    max: 10,
                    divisions: 9,
                    value: value ?? timeDilation,
                    onChanged: (num value) => timeDilation = value.toDouble(),
                  ),
                ],
              ),
            )) {
    // set default based on the input value
    if (value != null) {
      timeDilation = value;
    }
  }

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// Color picker shows a bottom sheet when tapped
  /// and a close button when color != defaultColor.
  SettingsTile.colorPicker({
    super.key,
    required BuildContext context,
    required Color color,
    required Color defaultColor,
    required ValueChanged<Color> onChanged,
    required this.title,
    this.enabled = _defaultEnabled,
    Widget? leading,
    BoxShape shape = BoxShape.rectangle,
    double? spacing,
    this.subtitle,
  })  : onTap = (() => _showBottomSheet(
              context: context,
              widget: ColorPicker(
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: shape,
                ),
                initialColor: color,
                spacing: spacing,
                title: title,
                onTap: (Color value) {
                  onChanged.call(value);
                  Navigator.of(context).pop();
                },
              ),
            )),
        leading = leading ??
            Icon(
              Icons.color_lens,
              color: color,
            ),
        trailing = defaultColor != color
            ? InkWell(
                child: const Icon(Icons.close),
                onTap: () => onChanged.call(defaultColor),
              )
            : null;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: leading,
      subtitle: subtitle,
      title: title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
