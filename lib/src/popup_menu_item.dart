part of flutter_widgetz;

/// {@template flutter_widgetz.CustomPopupMenuItem}
/// A [PopupMenuItem] with built in padding.
/// {@endtemplate}
class CustomPopupMenuItem<T> extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomPopupMenuItem}
  const CustomPopupMenuItem({
    Key? key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(8.0),
    this.value,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the menu item is tapped.
  final VoidCallback? onTap;

  /// The padding of the menu item.
  final EdgeInsets padding;

  /// The value that will be returned by [showMenu] if this entry is selected.
  final T? value;

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<T>(
      onTap: onTap,
      padding: padding,
      value: value,
      child: child,
    );
  }
}
