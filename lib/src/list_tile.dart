part of flutter_widgetz;

/// {@template flutter_widgetz.CustomListTile}
/// A [ListTile] with conveniences.
/// {@endtemplate}
class CustomListTile extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomListTile}
  CustomListTile({
    super.key,
    bool? dense,
    Widget? leading,
    String? leadingText,
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    Color? primaryColor,
    bool selected = false,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
    Widget? trailing,
    String? trailingText,
  }) : _content = _Tile(
          color: primaryColor,
          dense: dense,
          leading: leading,
          leadingText: leadingText,
          onTap: onTap,
          onLongPress: onLongPress,
          selected: selected,
          subtitle: subtitle,
          subtitleText: subtitleText,
          title: title,
          titleText: titleText,
          trailing: trailing,
          trailingText: trailingText,
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
    bool? dense,
    DismissDirection dismissDirection = DismissDirection.endToStart,
    IconData icon = Icons.delete,
    Widget? leading,
    String? leadingText,
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 20),
    Color? primaryColor,
    bool selected = false,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
    Widget? trailing,
    String? trailingText,
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
            color: primaryColor,
            dense: dense,
            leading: leading,
            leadingText: leadingText,
            onTap: onTap,
            onLongPress: onLongPress,
            selected: selected,
            subtitle: subtitle,
            subtitleText: subtitleText,
            title: title,
            titleText: titleText,
            trailing: trailing,
            trailingText: trailingText,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}

class _Tile extends ListTile {
  _Tile({
    Color? color,
    super.dense,
    Widget? leading,
    String? leadingText,
    super.onTap,
    super.onLongPress,
    super.selected,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
    Widget? trailing,
    String? trailingText,
  }) : super(
          leading: leading ??
              (leadingText != null
                  ? _Avatar(color: color, text: leadingText)
                  : null),
          subtitle:
              subtitle ?? (subtitleText != null ? Text(subtitleText) : null),
          title: title ?? (titleText != null ? Text(titleText) : null),
          trailing: trailing ??
              (trailingText != null
                  ? _Avatar(color: color, text: trailingText)
                  : null),
        );
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.text,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = this.color ?? theme.colorScheme.primary;

    return CircleAvatar(
      backgroundColor: color,
      child: Center(
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: color.blackOrWhite,
          ),
        ),
      ),
    );
  }
}
