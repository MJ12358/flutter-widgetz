part of flutter_widgetz;

/// {@template flutter_widgetz.SpacedRow}
/// Spaces a row of [children] with the given spacing.
/// {@endtemplate}
class SpacedRow extends StatelessWidget {
  /// {@macro flutter_widgetz.SpacedRow}
  const SpacedRow({
    Key? key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.spacing = 20.0,
    this.title,
    this.titleStyle,
  }) : super(key: key);

  /// Creates a horizontal array of children.
  final List<Widget> children;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The spacing between the children.
  final double spacing;

  /// An optional title to display above this row.
  final String? title;

  /// The style to use for the title.
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: <Widget>[
        if (title != null)
          Text(
            title!,
            style: titleStyle ?? Theme.of(context).textTheme.titleSmall,
          ),
        Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: _getChildren(),
        ),
      ],
    );
  }

  List<Widget> _getChildren() {
    final List<Widget> result = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];

      if (i != children.length - 1) {
        result.add(Expanded(child: child));
        result.add(SizedBox(width: spacing));
      } else {
        result.add(Expanded(child: child));
      }
    }

    return result;
  }
}
