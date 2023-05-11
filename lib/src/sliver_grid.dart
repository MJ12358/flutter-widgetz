part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSliverGrid}
/// Wraps [SliverGrid] in order to present it in a
/// way that is similar to [GridView].
/// {@endtemplate}
class CustomSliverGrid extends StatelessWidget {
  /// Creates a sliver that places multiple box
  /// children in a two dimensional arrangement.
  final SliverChildDelegate delegate;

  /// The delegate that controls the size and position of the children.
  final SliverGridDelegate gridDelegate;

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  static const EdgeInsets _defaultPadding = EdgeInsets.zero;

  /// {@macro flutter_widgetz.CustomSliverGrid}
  CustomSliverGrid.builder({
    super.key,
    required this.gridDelegate,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    this.padding = _defaultPadding,
  }) : delegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  /// {@macro flutter_widgetz.CustomSliverGrid}
  CustomSliverGrid.count({
    super.key,
    required List<Widget> children,
    required int crossAxisCount,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    this.padding = _defaultPadding,
  })  : gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        delegate = SliverChildListDelegate(
          children,
        );

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
        delegate: delegate,
        gridDelegate: gridDelegate,
      ),
    );
  }
}
