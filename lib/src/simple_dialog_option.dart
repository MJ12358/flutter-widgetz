part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSimpleDialogOption}
/// A [SimpleDialogOption] with built in padding.
/// {@endtemplate}
class CustomSimpleDialogOption extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomSimpleDialogOption}
  const CustomSimpleDialogOption({
    Key? key,
    required this.child,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 24.0,
    ),
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// The callback that is called when this option is selected.
  final VoidCallback onPressed;

  /// The amount of space to surround the [child] with.
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
