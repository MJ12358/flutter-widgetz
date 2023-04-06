part of flutter_widgetz;

class CustomDivider extends StatelessWidget {
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
