part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSliverList}
/// Wraps [SliverList] in order to present it in a
/// way that is similar to [ListView].
/// {@endtemplate}
class CustomSliverList extends StatelessWidget {
  /// {@macro flutter_wigetz.CustomSliverList}
  const CustomSliverList._({
    Key? key,
    required this.delegate,
    EdgeInsets? padding,
  })  : padding = padding ?? EdgeInsets.zero,
        super(key: key);

  /// Creates a sliver that places box children in a linear array.
  final SliverChildDelegate delegate;

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  /// {@macro flutter_widgetz.CustomSliverList}
  factory CustomSliverList.builder({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    EdgeInsets? padding,
  }) {
    return CustomSliverList._(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      padding: padding,
    );
  }

  /// {@macro flutter_widgetz.CustomSliverList}
  factory CustomSliverList.separated({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    EdgeInsets? padding,
  }) {
    return CustomSliverList._(
      delegate: SliverChildBuilderDelegate(
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
      ),
      padding: padding,
    );
  }

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
