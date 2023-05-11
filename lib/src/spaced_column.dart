part of flutter_widgetz;

/// {@template flutter_widgetz.SpacedColumn}
/// Spaces [children] with the given spacing.
/// {@endtemplate}
class SpacedColumn extends StatelessWidget {
  /// {@macro flutter_widgetz.SpacedColumn}
  const SpacedColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 20.0,
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

    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];

      if (i != children.length - 1) {
        result.add(child);
        result.add(SizedBox(height: spacing));
      } else {
        result.add(child);
      }
    }

    return result;
  }
}
