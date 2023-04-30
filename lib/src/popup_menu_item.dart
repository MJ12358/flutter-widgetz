part of flutter_widgetz;

/// {@template flutter_widgetz.CustomPopupMenuItem}
/// A [PopupMenuItem] with built in padding.
/// This uses the default horizontal padding of 16,
/// with a additional vertical of 8.
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

  /// A [PopupMenuItem] with a checkmark.
  factory CustomPopupMenuItem.checked({
    required String text,
    bool checked = true,
    bool enabled = true,
    VoidCallback? onTap,
    T? value,
  }) {
    return CustomPopupMenuItem<T>(
      enabled: enabled,
      onTap: onTap,
      padding: EdgeInsets.zero,
      value: value,
      child: ListTile(
        leading: AnimatedOpacity(
          opacity: checked ? 1.0 : 0.15,
          duration: kThemeChangeDuration,
          child: const Icon(Icons.done),
        ),
        title: Text(text),
      ),
    );
  }

  /// A [PopupMenuItem] with an icon.
  factory CustomPopupMenuItem.icon({
    required String text,
    required IconData icon,
    bool enabled = true,
    VoidCallback? onTap,
    T? value,
  }) {
    return CustomPopupMenuItem<T>(
      enabled: enabled,
      onTap: onTap,
      padding: EdgeInsets.zero,
      value: value,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }
}
