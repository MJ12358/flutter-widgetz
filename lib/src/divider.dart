part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDivider}
/// This widget places a [child]
/// between two dividers.
/// {@endtemplate}
class CustomDivider extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDivider}
  const CustomDivider({
    super.key,
    this.child,
    this.color,
    this.spacing = 8.0,
    this.thickness,
  });

  /// The widget to be displayed between the dividers.
  final Widget? child;

  /// The color to use when painting the line.
  final Color? color;

  /// The spacing between the child and dividers.
  final double spacing;

  /// The thickness of the line drawn within the divider.
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _getTheme(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            child: Divider(),
          ),
          if (child != null) ...<Widget>[
            SizedBox(width: spacing),
            child!,
            SizedBox(width: spacing),
          ],
          const Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }

  ThemeData _getTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      dividerTheme: theme.dividerTheme.copyWith(
        color: color,
        thickness: thickness,
      ),
      iconTheme: theme.iconTheme.copyWith(
        color: theme.scaffoldBackgroundColor.blackOrWhite,
      ),
    );
  }
}
