part of flutter_widgetz;

/// {@template flutter_widgetz.SpacedColumn}
/// Spaces [children] with the given spacing.
/// {@endtemplate}
class SpacedColumn extends StatelessWidget {
  /// {@macro flutter_widgetz.SpacedColumn}
  const SpacedColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = _defaultCrossAxisAlignment,
    this.mainAxisAlignment = _defaultMainAxisAlignment,
    this.mainAxisSize = _defaultMainAxisSize,
    this.spacing = _defaultSpacing,
    this.spacer,
  });

  /// Creates a vertical array of children.
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

  static const CrossAxisAlignment _defaultCrossAxisAlignment =
      CrossAxisAlignment.center;

  static const MainAxisAlignment _defaultMainAxisAlignment =
      MainAxisAlignment.start;

  static const MainAxisSize _defaultMainAxisSize = MainAxisSize.max;

  static const double _defaultSpacing = 20.0;

  // TODO: need to find the type of widget that is returned from "build"
  // then determine its height and/or width
  // as just checking for "SizedBox" does not achieve the required result
  static bool _defaultFilter(Widget e) {
    if (e is SizedBox) {
      if ((e.height ?? 0) <= 0 && (e.width ?? 0) <= 0) {
        return false;
      }
    }
    return true;
  }

  /// {@macro flutter_widgetz.SpacedColumn}
  ///
  /// Filtered is used to filter out undesirable widgets.
  /// This defaults to removing SizedBoxes with 0 height/width.
  SpacedColumn.filtered({
    super.key,
    required List<Widget> children,
    bool Function(Widget)? filter,
    this.crossAxisAlignment = _defaultCrossAxisAlignment,
    this.mainAxisAlignment = _defaultMainAxisAlignment,
    this.mainAxisSize = _defaultMainAxisSize,
    this.spacing = _defaultSpacing,
    this.spacer,
  }) : children = children.where(filter ?? _defaultFilter).toList();

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: _getChildren(),
    );
  }

  List<Widget> _getChildren() {
    final List<Widget> result = <Widget>[];
    final Widget _spacer = spacer ?? SizedBox(height: spacing);

    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];

      if (i != children.length - 1) {
        result.add(child);
        result.add(_spacer);
      } else {
        result.add(child);
      }
    }

    return result;
  }
}
