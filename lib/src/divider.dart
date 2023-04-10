part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDivider}
/// This widget places a [child]
/// between two dividers.
/// {@endtemplate}
class CustomDivider extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDivider}
  const CustomDivider({
    Key? key,
    this.child,
    this.spacing = 8.0,
  }) : super(key: key);

  final Widget? child;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
