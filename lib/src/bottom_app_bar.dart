part of flutter_widgetz;

/// {@template flutter_widgetz.CustomBottomAppBar}
/// Creates a bottom application bar.
/// {@endtemplate}
class CustomBottomAppBar extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomBottomAppBar}
  const CustomBottomAppBar({
    super.key,
    required this.children,
    this.clipBehavior = Clip.none,
    this.color,
    this.iconColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.padding,
    this.shape,
  });

  /// The widgets below this widget in the tree.
  final List<Widget> children;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// The bottom app bar's background color.
  final Color? color;

  /// The default for [Icon.color].
  final Color? iconColor;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The amount of space to surround the child inside the
  /// bounds of the [BottomAppBar].
  final EdgeInsets? padding;

  /// The notch that is made for the floating action button.
  final NotchedShape? shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BottomAppBar(
      clipBehavior: clipBehavior,
      color: color ?? theme.colorScheme.secondary,
      padding: padding,
      shape: shape,
      child: IconTheme(
        data: IconThemeData(
          color: iconColor ?? theme.colorScheme.secondary.blackOrWhite,
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: children.isNotEmpty ? children : <Widget>[const SizedBox()],
        ),
      ),
    );
  }
}
