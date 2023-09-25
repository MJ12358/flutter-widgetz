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
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.height,
    this.iconColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.notchMargin = 4.0,
    this.padding,
    this.shape,
  });

  /// The widgets below this widget in the tree.
  final List<Widget> children;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// The bottom app bar's background color.
  final Color? color;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The double value used to indicate the height of the [BottomAppBar].
  final double? height;

  /// The default for [Icon.color].
  final Color? iconColor;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The margin between the [FloatingActionButton]
  /// and the [BottomAppBar]'s notch.
  final double notchMargin;

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
      height: height,
      notchMargin: notchMargin,
      padding: padding,
      shape: shape,
      child: IconTheme(
        data: IconThemeData(
          color: iconColor ?? theme.colorScheme.secondary.blackOrWhite,
        ),
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: children.isNotEmpty ? children : <Widget>[const SizedBox()],
        ),
      ),
    );
  }
}
