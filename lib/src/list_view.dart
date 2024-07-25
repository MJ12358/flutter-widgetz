part of flutter_widgetz;

/// {@template flutter_widgetz.CustomListView}
/// A custom list view.
/// {@endtemplate}
class CustomListView extends StatelessWidget {
  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// The total count of children.
  final int itemCount;

  /// Signature for a function that creates a widget for a given index.
  final IndexedWidgetBuilder itemBuilder;

  /// The amount of space by which to inset the children.
  final EdgeInsets? padding;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Signature for a function that creates a widget for a given index.
  final IndexedWidgetBuilder separatorBuilder;

  /// Whether the extent of the scroll view should be
  /// determined by the contents being viewed.
  final bool shrinkWrap;

  static const Widget _defaultSeparator = SizedBox();

  /// {@macro flutter_widgetz.CustomListView}
  ///
  /// Static never scrolls.
  CustomListView.static({
    super.key,
    required List<Widget> children,
    this.clipBehavior = Clip.none,
    this.padding,
    Widget? separator,
  })  : itemCount = children.length,
        itemBuilder = ((BuildContext context, int index) {
          return children[index];
        }),
        physics = const NeverScrollableScrollPhysics(),
        separatorBuilder = ((BuildContext context, int index) {
          return separator ?? _defaultSeparator;
        }),
        shrinkWrap = true;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: clipBehavior,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: padding,
      physics: physics,
      separatorBuilder: separatorBuilder,
      shrinkWrap: shrinkWrap,
    );
  }
}
