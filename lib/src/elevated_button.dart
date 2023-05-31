part of flutter_widgetz;

/// {@template flutter_widgetz.CustomElevatedButton}
/// An [ElevatedButton] that utilizes the
/// full width of its container.
/// {@endtemplate}
class CustomElevatedButton extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomElevatedButton}
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
  });

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The button's label.
  final String text;

  /// The button's color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: _getStyle(context),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text.toUpperCase(),
          ),
        ),
      ),
    );
  }

  ButtonStyle _getStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonStyle? _style = theme.elevatedButtonTheme.style;
    final Color _primary = theme.colorScheme.primary;

    // when elevated button style is set by ThemeData, copyWith
    if (_style != null) {
      return _style.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((_) {
          return color ?? _primary;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((_) {
          return color?.blackOrWhite ?? _primary.blackOrWhite;
        }),
      );
    }

    // otherwise convert to simple values
    return ElevatedButton.styleFrom(
      backgroundColor: color ?? _primary,
      foregroundColor: color?.blackOrWhite ?? _primary.blackOrWhite,
    );
  }
}
