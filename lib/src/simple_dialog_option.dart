part of flutter_widgetz;

/// A [SimpleDialogOption] with built in padding.
class CustomSimpleDialogOption extends StatelessWidget {
  const CustomSimpleDialogOption({
    Key? key,
    required this.child,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 24.0,
    ),
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      padding: padding,
      onPressed: onPressed,
      child: child,
    );
  }
}
