part of flutter_widgetz;

/// {@template flutter_widgetz.SpacedRow}
/// Spaces a row of [children] with the given spacing.
/// {@endtemplate}
class SpacedRow extends StatelessWidget {
  /// {@macro flutter_widgetz.SpacedRow}
  const SpacedRow({
    super.key,
    required this.children,
    this.crossAxisAlignment = _defaultCrossAxisAlignment,
    this.mainAxisAlignment = _defaultMainAxisAlignment,
    this.mainAxisSize = _defaultMainAxisSize,
    this.spacer = _defaultSpacer,
    this.title,
  });

  /// Creates a horizontal array of children.
  final List<Widget> children;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// The spacer between the children.
  final Widget spacer;

  /// An optional title to display above this row.
  final Widget? title;

  static const CrossAxisAlignment _defaultCrossAxisAlignment =
      CrossAxisAlignment.end;
  static const MainAxisAlignment _defaultMainAxisAlignment =
      MainAxisAlignment.spaceEvenly;
  static const MainAxisSize _defaultMainAxisSize = MainAxisSize.max;
  static const Widget _defaultSpacer = SizedBox(width: 20.0);

  static bool _defaultFilter(Widget e) {
    if (e is SizedBox) {
      if ((e.height ?? 0) <= 0 && (e.width ?? 0) <= 0) {
        return false;
      }
    }
    return true;
  }

  /// {@macro flutter_widgetz.SpacedRow}
  ///
  /// Filtered is used to filter out undesirable widgets.
  /// This defaults to removing [SizedBox] with 0 height/width.
  SpacedRow.filtered({
    super.key,
    required List<Widget> children,
    bool Function(Widget)? filter,
    this.crossAxisAlignment = _defaultCrossAxisAlignment,
    this.mainAxisAlignment = _defaultMainAxisAlignment,
    this.mainAxisSize = _defaultMainAxisSize,
    this.spacer = _defaultSpacer,
    this.title,
  }) : children = children.where(filter ?? _defaultFilter).toList();

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        if (title != null)
          DefaultTextStyle.merge(
            style: theme.textTheme.titleSmall,
            child: title!,
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

    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];

      if (i != children.length - 1) {
        result.add(Expanded(child: child));
        result.add(spacer);
      } else {
        result.add(Expanded(child: child));
      }
    }

    return result;
  }
}
