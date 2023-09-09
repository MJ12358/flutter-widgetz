part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSimpleDialogOption}
/// A [SimpleDialogOption] with built in padding.
/// This fixes an accessibility warning in the Google Play Console.
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

  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  ///
  /// Checked uses a checkmark based on the [checked] property.
  CustomSimpleDialogOption.checked({
    super.key,
    required String text,
    bool checked = true,
    super.onPressed,
  }) : super(
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

  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  ///
  /// Icon uses an icon.
  CustomSimpleDialogOption.icon({
    super.key,
    required String text,
    required IconData icon,
    super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: Icon(icon),
            title: Text(text),
          ),
        );

  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  ///
  /// Tile wraps the child in a [ListTile].
  CustomSimpleDialogOption.tile({
    super.key,
    required Widget child,
    super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: child,
          ),
        );
}
