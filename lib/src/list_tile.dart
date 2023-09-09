part of flutter_widgetz;

/// {@template flutter_widgetz.CustomListTile}
/// A [ListTile] with conveniences.
/// {@endtemplate}
class CustomListTile extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomListTile}
  CustomListTile({
    super.key,
    Widget? leading,
    String? leadingText,
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    bool selected = false,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
    Widget? trailing,
  }) : _content = _Tile(
          onTap: onTap,
          onLongPress: onLongPress,
          leading: leading,
          leadingText: leadingText,
          selected: selected,
          title: title,
          titleText: titleText,
          subtitle: subtitle,
          subtitleText: subtitleText,
          trailing: trailing,
        );

  /// Internal prop to hold the widget to be built.
  final Widget _content;

  /// {@macro flutter_widgetz.CustomListTile}
  ///
  /// Dismissible wraps the [ListTile] inside a [Dismissible].
  CustomListTile.dismissible({
    super.key,
    required Object uniqueKey,
    required VoidCallback onDismissed,
    Color color = Colors.red,
    AsyncValueGetter<bool?>? confirmDismiss,
    DismissDirection dismissDirection = DismissDirection.endToStart,
    IconData icon = Icons.delete,
    Widget? leading,
    String? leadingText,
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 20),
    bool selected = false,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
    Widget? trailing,
  }) : _content = Dismissible(
          key: ValueKey<Object>(uniqueKey),
          direction: dismissDirection,
          background: Container(
            alignment: Alignment.centerRight,
            color: color,
            padding: padding,
            child: Icon(icon),
          ),
          onDismissed: (_) => onDismissed(),
          confirmDismiss: (_) =>
              confirmDismiss?.call() ?? Future<bool>.value(true),
          child: _Tile(
            onTap: onTap,
            onLongPress: onLongPress,
            leading: leading,
            leadingText: leadingText,
            selected: selected,
            subtitle: subtitle,
            subtitleText: subtitleText,
            title: title,
            titleText: titleText,
            trailing: trailing,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}

class _Tile extends ListTile {
  _Tile({
    Widget? leading,
    String? leadingText,
    super.onTap,
    super.onLongPress,
    super.selected,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
    super.trailing,
  }) : super(
          leading: leading ??
              (leadingText != null ? _Leading(text: leadingText) : null),
          subtitle:
              subtitle ?? (subtitleText != null ? Text(subtitleText) : null),
          title: title ?? (titleText != null ? Text(titleText) : null),
        );
}

class _Leading extends StatelessWidget {
  const _Leading({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CircleAvatar(
      backgroundColor: theme.colorScheme.primary,
      child: Center(
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary.blackOrWhite,
          ),
        ),
      ),
    );
  }
}
