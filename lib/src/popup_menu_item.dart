part of flutter_widgetz;

/// {@template flutter_widgetz.CustomPopupMenuItem}
/// A [PopupMenuItem] with built in padding.
/// This uses the default horizontal padding of 16,
/// with a additional vertical of 8.
///
///![CustomPopupMenuItem](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/popup_menu_item.png)
/// {@endtemplate}
class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  /// {@macro flutter_widgetz.CustomPopupMenuItem}
  const CustomPopupMenuItem({
    super.key,
    required super.child,
    super.enabled,
    super.height = kMinInteractiveDimension + 8.0,
    super.onTap,
    super.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    super.value,
  });

  static double _getOpacity(bool checked) {
    return checked ? 1.0 : 0.15;
  }

  /// A [PopupMenuItem] with a checkmark.
  ///
  /// {@macro flutter_widgetz.CustomPopupMenuItem}
  CustomPopupMenuItem.checked({
    super.key,
    required Widget child,
    bool checked = false,
    super.enabled = true,
    super.onTap,
    super.value,
  }) : super(
          child: ListTile(
            leading: AnimatedOpacity(
              opacity: _getOpacity(checked),
              duration: kThemeChangeDuration,
              child: const Icon(Icons.done),
            ),
            title: child,
          ),
        );

  /// A [PopupMenuItem] with an icon.
  ///
  /// {@macro flutter_widgetz.CustomPopupMenuItem}
  CustomPopupMenuItem.icon({
    super.key,
    required Widget child,
    required IconData icon,
    super.onTap,
    super.value,
  }) : super(
          child: ListTile(
            leading: Icon(icon),
            title: child,
          ),
        );

  /// A [PopupMenuItem] with an leading icon
  /// and a trailing checkmark.
  ///
  /// {@macro flutter_widgetz.CustomPopupMenuItem}
  CustomPopupMenuItem.iconChecked({
    super.key,
    required Widget child,
    required IconData icon,
    bool checked = false,
    super.onTap,
    super.value,
  }) : super(
          child: ListTile(
            leading: Icon(icon),
            title: child,
            trailing: AnimatedOpacity(
              opacity: _getOpacity(checked),
              duration: kThemeChangeDuration,
              child: const Icon(Icons.done),
            ),
          ),
        );
}
