part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSliverGrid}
/// Wraps [SliverGrid] in order to present it in a
/// way that is similar to [GridView].
/// {@endtemplate}
class CustomSliverGrid extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomSliverGrid}
  const CustomSliverGrid._({
    Key? key,
    required this.delegate,
    required this.gridDelegate,
    EdgeInsets? padding,
  })  : padding = padding ?? EdgeInsets.zero,
        super(key: key);

  /// Creates a sliver that places multiple box
  /// children in a two dimensional arrangement.
  final SliverChildDelegate delegate;

  /// The delegate that controls the size and position of the children.
  final SliverGridDelegate gridDelegate;

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  /// {@macro flutter_widgetz.CustomSliverGrid}
  factory CustomSliverGrid.builder({
    required SliverGridDelegate gridDelegate,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    EdgeInsets? padding,
  }) {
    return CustomSliverGrid._(
      gridDelegate: gridDelegate,
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      padding: padding,
    );
  }

  /// {@macro flutter_widgetz.CustomSliverGrid}
  factory CustomSliverGrid.count({
    required List<Widget> children,
    required int crossAxisCount,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    EdgeInsets? padding,
  }) {
    return CustomSliverGrid._(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      delegate: SliverChildListDelegate(
        children,
      ),
      padding: padding,
    );
  }

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
