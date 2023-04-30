part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSimpleDialogOption}
/// A [SimpleDialogOption] with built in padding.
/// This fixes an accessibility warning in Google Play Console.
/// {@endtemplate}
class CustomSimpleDialogOption extends SimpleDialogOption {
  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  const CustomSimpleDialogOption({
    super.key,
    super.child,
    super.onPressed,
    super.padding = const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 24.0,
    ),
  });

  /// A [SimpleDialogOption] with a checkmark.
  factory CustomSimpleDialogOption.checked({
    required String text,
    bool checked = true,
    VoidCallback? onPressed,
  }) {
    return CustomSimpleDialogOption(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
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

  /// A [SimpleDialogOption] with an icon.
  factory CustomSimpleDialogOption.icon({
    required String text,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return CustomSimpleDialogOption(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }

  /// A [SimpleDialogOption] that wraps the child in a [ListTile].
  factory CustomSimpleDialogOption.tile({
    required Widget child,
    VoidCallback? onPressed,
  }) {
    return CustomSimpleDialogOption(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: ListTile(
        title: child,
      ),
    );
  }
}
