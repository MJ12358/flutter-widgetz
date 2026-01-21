part of flutter_widgetz;

/// {@template flutter_widgetz.Link}
/// A [Text] widget wrapped in an [InkWell].
///
///![Link](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/link.png)
/// {@endtemplate}
class Link extends StatelessWidget {
  /// {@macro flutter_widgetz.Link}
  const Link(
    this.child, {
    super.key,
    this.color = _defaultColor,
    this.onTap,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The text color.
  final Color color;

  /// Called when the user taps this part of the material.
  final VoidCallback? onTap;

  static const Color _defaultColor = Color(0xFF0000EE);

  /// With an included underline.
  ///
  /// {@macro flutter_widgetz.Link}
  Link.underline(
    Widget child, {
    super.key,
    this.color = _defaultColor,
    this.onTap,
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
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle().copyWith(
        color: color,
      ),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
