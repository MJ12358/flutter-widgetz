part of flutter_widgetz;

/// {@template flutter_widgetz.CustomElevatedButton}
/// An [ElevatedButton] that utilizes the
/// full width of its container.
///
///![CustomElevatedButton](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/elevated_button.png)
/// {@endtemplate}
class CustomElevatedButton extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomElevatedButton}
  const CustomElevatedButton({
    super.key,
    required this.child,
    this.color,
    this.onPressed,
  });

  /// The button's label.
  final Widget child;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The button's color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: _getStyle(context),
      ),
      child: SizedBox(
        height: _kDefaultButtonHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }

  ButtonStyle _getStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonStyle? style = theme.elevatedButtonTheme.style;
    final Color primary = theme.colorScheme.primary;

    // when elevated button style is set by ThemeData, copyWith
    if (style != null) {
      return style.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((_) {
          return color ?? primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((_) {
          return color?.blackOrWhite ?? primary.blackOrWhite;
        }),
      );
    }

    // otherwise convert to simple values
    return ElevatedButton.styleFrom(
      backgroundColor: color ?? primary,
      foregroundColor: color?.blackOrWhite ?? primary.blackOrWhite,
    );
  }
}
