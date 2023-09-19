part of flutter_widgetz;

/// {@template flutter_widgetz.Link}
/// A [Text] widget wrapped in an [InkWell].
/// {@endtemplate}
class Link extends StatelessWidget {
  /// {@macro flutter_widgetz.Link}
  Link(
    String text, {
    super.key,
    this.color = _defaultColor,
    this.onTap,
    this.textStyle = _defaultTextStyle,
  }) : child = Text(text);

  /// The widget below this widget in the tree.
  final Widget child;

  /// The text color.
  final Color color;

  /// Called when the user taps this part of the material.
  final VoidCallback? onTap;

  /// The style to use for this text.
  final TextStyle textStyle;

  static const Color _defaultColor = Color(0xFF0000EE);
  static const TextStyle _defaultTextStyle = TextStyle();

  /// {@macro flutter_widgetz.Link}
  ///
  /// With an included underline.
  Link.underline(
    String text, {
    super.key,
    this.color = _defaultColor,
    this.onTap,
    this.textStyle = _defaultTextStyle,
  }) : child = Container(
          padding: const EdgeInsets.only(
            bottom: 1.0,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color,
              ),
            ),
          ),
          child: Text(text),
        );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle.copyWith(
        color: color,
      ),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
