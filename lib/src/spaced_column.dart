part of flutter_widgetz;

/// Spaces [children] with the given spacing.
class SpacedColumn extends StatelessWidget {
  const SpacedColumn({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.spacing = 20.0,
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: _formatChildren(),
    );
  }

  List<Widget> _formatChildren() {
    final List<Widget> result = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      if (i != children.length - 1) {
        result.add(children[i]);
        result.add(SizedBox(height: spacing));
      } else {
        result.add(children[i]);
      }
    }

    return result;
  }
}
