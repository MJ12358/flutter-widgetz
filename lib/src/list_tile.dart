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
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    Color? primaryColor,
    bool selected = false,
    Widget? subtitle,
    Widget? title,
    Widget? trailing,
  }) : _content = _Tile(
          color: primaryColor,
          dense: dense,
          leading: leading,
          onTap: onTap,
          onLongPress: onLongPress,
          selected: selected,
          subtitle: subtitle,
          title: title,
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
    bool? dense,
    DismissDirection dismissDirection = DismissDirection.endToStart,
    IconData icon = Icons.delete,
    Widget? leading,
    VoidCallback? onLongPress,
    VoidCallback? onTap,
    EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 20),
    Color? primaryColor,
    bool selected = false,
    Widget? subtitle,
    Widget? title,
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
            color: primaryColor,
            dense: dense,
            leading: leading,
            onTap: onTap,
            onLongPress: onLongPress,
            selected: selected,
            subtitle: subtitle,
            title: title,
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
    Color? color,
    super.dense,
    Widget? leading,
    super.onTap,
    super.onLongPress,
    super.selected,
    super.subtitle,
    super.title,
    Widget? trailing,
  }) : super(
          leading: leading != null
              ? _Avatar(
                  color: color,
                  child: leading,
                )
              : null,
          trailing: trailing != null
              ? _Avatar(
                  color: color,
                  child: trailing,
                )
              : null,
        );
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.child,
    this.color,
  });

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = this.color ?? theme.colorScheme.primary;

    return CircleAvatar(
      backgroundColor: color,
      child: Center(
        child: DefaultTextStyle.merge(
          style: theme.textTheme.titleMedium?.copyWith(
            color: color.blackOrWhite,
          ),
          child: child,
        ),
      ),
    );
  }
}
