part of flutter_widgetz;

/// {@template flutter_widgetz.SpacedRow}
/// Spaces a row of [children] with the given spacing.
/// {@endtemplate}
class SpacedRow extends StatelessWidget {
  /// {@macro flutter_widgetz.SpacedRow}
  const SpacedRow({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 20.0,
    this.spacer,
    this.title,
    this.titleStyle,
  });

  /// Creates a horizontal array of children.
  final List<Widget> children;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// The spacing between the children.
  final double spacing;

  /// The spacer between the children.
  final Widget? spacer;

  /// An optional title to display above this row.
  final String? title;

  /// The style to use for the title.
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox();
    }

    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        if (title != null)
          Text(
            title!,
            style: titleStyle ?? theme.textTheme.titleSmall,
          ),
        Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: _getChildren(),
        ),
      ],
    );
  }

  List<Widget> _getChildren() {
    final List<Widget> result = <Widget>[];
    final Widget _spacer = spacer ?? SizedBox(width: spacing);

    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];

      if (i != children.length - 1) {
        result.add(Expanded(child: child));
        result.add(_spacer);
      } else {
        result.add(Expanded(child: child));
      }
    }

    return result;
  }
}
