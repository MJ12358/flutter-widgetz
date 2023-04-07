part of flutter_widgetz;

/// Spaces [children] with the given spacing.
class SpacedRow extends StatelessWidget {
  const SpacedRow({
    Key? key,
    required this.children,
    this.title,
    this.spacing = 20.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  }) : super(key: key);

  final List<Widget> children;
  final String? title;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

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
            style: Theme.of(context).textTheme.titleSmall,
          ),
        Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: _formatChildren(),
        ),
      ],
    );
  }

  List<Widget> _formatChildren() {
    final List<Widget> result = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      if (i != children.length - 1) {
        result.add(Expanded(child: children[i]));
        result.add(SizedBox(width: spacing));
      } else {
        result.add(Expanded(child: children[i]));
      }
    }

    return result;
  }
}
