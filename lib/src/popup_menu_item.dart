part of flutter_widgetz;

/// {@template flutter_widgetz.CustomPopupMenuItem}
/// A [PopupMenuItem] with built in padding.
/// {@endtemplate}
class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  /// {@macro flutter_widgetz.CustomPopupMenuItem}
  const CustomPopupMenuItem({
    super.key,
    required super.child,
    super.onTap,
    super.padding = const EdgeInsets.all(8.0),
    super.value,
  });
}
