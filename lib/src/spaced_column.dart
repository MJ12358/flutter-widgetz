part of flutter_widgetz;

/// {@template flutter_widgetz.SpacedColumn}
/// Spaces [children] with the given spacing.
/// {@endtemplate}
class SpacedColumn extends StatelessWidget {
  /// {@macro flutter_widgetz.SpacedColumn}
  const SpacedColumn({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.spacing = 20.0,
  }) : super(key: key);

  /// Creates a vertical array of children.
  final List<Widget> children;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The spacing between the children.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
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
