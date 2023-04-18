part of flutter_widgetz;

typedef WidgetBuilder = Widget Function(BuildContext, int);

class CustomSliverList extends StatelessWidget {
  const CustomSliverList._({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  final SliverChildDelegate delegate;

  factory CustomSliverList.builder({
    required int itemCount,
    required WidgetBuilder itemBuilder,
  }) {
    return CustomSliverList._(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
  }

  factory CustomSliverList.separated({
    required int itemCount,
    required WidgetBuilder itemBuilder,
    required WidgetBuilder separatorBuilder,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: delegate,
    );
  }

  // Helper method to compute the actual child count
  // for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
