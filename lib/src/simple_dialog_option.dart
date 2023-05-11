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

  /// A [SimpleDialogOption] with an icon.
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

  /// A [SimpleDialogOption] that wraps the child in a [ListTile].
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
