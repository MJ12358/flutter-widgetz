part of flutter_widgetz;

/// {@template flutter_widgetz.Button}
/// Buttons are clickable items used to perform an action.
///
///![Button](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/button.png)
/// {@endtemplate}
class Button extends StatelessWidget {
  /// {@macro flutter_widgetz.Button}
  const Button({
    super.key,
    this.border = _defaultBorder,
    this.child,
    this.color,
    this.onPressed,
  });

  /// Creates the side of a border.
  final BorderSide border;

  /// The button's label.
  final Widget? child;

  /// The button's color.
  final Color? color;

  /// The callback that is called when the button is tapped.
  final VoidCallback? onPressed;

  static const Color _defaultColor = Color(0xFF0176D3);
  static const BorderSide _defaultBorder = BorderSide.none;

  /// Brand uses a blue color.
  ///
  /// {@macro flutter_widgetz.Button}
  const Button.brand({
    super.key,
    this.child,
    this.onPressed,
  })  : border = _defaultBorder,
        color = _defaultColor;

  /// Destructive uses a red color.
  ///
  /// {@macro flutter_widgetz.Button}
  const Button.destructive({
    super.key,
    this.child,
    this.onPressed,
  })  : border = _defaultBorder,
        color = const Color(0xFFBA0517);

  /// Inverse uses a dark blue color.
  ///
  /// {@macro flutter_widgetz.Button}
  const Button.inverse({
    super.key,
    this.child,
    this.onPressed,
  })  : border = _defaultBorder,
        color = const Color(0xFF16325C);

  /// Neutral uses the default color with a border.
  ///
  /// {@macro flutter_widgetz.Button}
  const Button.neutral({
    super.key,
    this.child,
    this.onPressed,
  })  : border = const BorderSide(color: Color(0xFFC9C9C9)),
        color = null;

  /// Outline uses a [color] to create a border.
  ///
  /// {@macro flutter_widgetz.Button}
  Button.outline({
    super.key,
    Color? color,
    this.child,
    this.onPressed,
  })  : border = BorderSide(color: color ?? _defaultColor),
        color = null;

  /// Success uses a green color.
  ///
  /// {@macro flutter_widgetz.Button}
  const Button.success({
    super.key,
    this.child,
    this.onPressed,
  })  : border = _defaultBorder,
        color = const Color(0xFF45C65A);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        side: border,
      ),
      child: MaterialButton(
        color: color,
        onPressed: onPressed,
        textColor: color?.blackOrWhite,
        child: child,
      ),
    );
  }
}
