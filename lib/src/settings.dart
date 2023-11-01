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

  /// {@macro flutter_widgetz.SettingsTile}
  ///
  /// Switched uses a [Switch] as the trailing widget.
  SettingsTile.switched({
    super.key,
    required this.title,
    required bool value,
    this.enabled = _defaultEnabled,
    this.leading,
    ValueChanged<bool>? onChanged,
    this.subtitle,
  })  : onTap = null,
        trailing = Switch(
          value: value,
          onChanged: (bool value) => onChanged?.call(value),
        );

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
