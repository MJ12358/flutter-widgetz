part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSimpleDialogOption}
/// A [SimpleDialogOption] with built in padding.
/// This fixes an accessibility warning in the Google Play Console.
///
///![CustomSimpleDialogOption](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/simple_dialog_option.png)
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

  /// Checked uses a checkmark based on the [checked] property.
  ///
  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  CustomSimpleDialogOption.checked({
    super.key,
    required Widget child,
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
            title: child,
          ),
        );

  /// Icon uses an [Icon].
  ///
  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  CustomSimpleDialogOption.icon({
    super.key,
    required Widget child,
    required Widget icon,
    super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: icon,
            title: child,
          ),
        );

  /// Tile wraps the child in a [ListTile].
  ///
  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
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
