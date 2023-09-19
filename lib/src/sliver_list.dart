part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSliverList}
/// Wraps [SliverList] in order to present it in a
/// way that is similar to [ListView].
/// {@endtemplate}
class CustomSliverList extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomSliverList}
  const CustomSliverList({
    super.key,
    required this.delegate,
    this.padding = _defaultPadding,
  });

  /// Creates a sliver that places box children in a linear array.
  final SliverChildDelegate delegate;

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  static const EdgeInsets _defaultPadding = EdgeInsets.zero;

  /// {@macro flutter_widgetz.CustomSliverList}
  ///
  /// Builder uses a [SliverChildBuilderDelegate].
  CustomSliverList.builder({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    this.padding = _defaultPadding,
  }) : delegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  /// {@macro flutter_widgetz.CustomSliverList}
  ///
  /// List uses a [SliverChildListDelegate].
  CustomSliverList.list({
    super.key,
    required List<Widget> children,
    this.padding = _defaultPadding,
  }) : delegate = SliverChildListDelegate(
          children,
        );

  /// {@macro flutter_widgetz.CustomSliverList}
  ///
  /// Separated uses a [SliverChildBuilderDelegate]
  /// and inserts a separator between widgets.
  CustomSliverList.separated({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    this.padding = _defaultPadding,
  }) : delegate = SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget widget;
            if (index.isEven) {
              widget = itemBuilder(context, itemIndex);
            } else {
              widget = separatorBuilder(context, itemIndex);
            }
            return widget;
          },
          childCount: _computeActualChildCount(itemCount),
          semanticIndexCallback: (_, int index) {
            return index.isEven ? index ~/ 2 : null;
          },
        );

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: delegate,
      ),
    );
  }

  // Helper method to compute the actual child count
  // for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
