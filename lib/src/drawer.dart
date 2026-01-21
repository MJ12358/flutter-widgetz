part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDrawer}
/// A [Drawer] that uses a [CustomScrollView].
///
///![CustomDrawer](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/drawer.png)
/// {@endtemplate}
class CustomDrawer extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDrawer}
  const CustomDrawer({
    super.key,
    required this.delegate,
    this.color,
    this.header,
    this.semanticLabel,
  });

  /// A delegate that provides the children for the [PageView].
  final SliverChildDelegate delegate;

  /// The background color applied to the [header].
  final Color? color;

  /// A widget to be placed inside the drawer header.
  final Widget? header;

  /// The semantic label of the drawer.
  final String? semanticLabel;

  /// Count uses [SliverChildListDelegate].
  ///
  /// {@macro flutter_widgetz.CustomDrawer}
  CustomDrawer.count({
    super.key,
    required List<Widget> children,
    this.color,
    this.header,
    this.semanticLabel,
  }) : delegate = SliverChildListDelegate(
          children,
        );

  /// Builder uses [SliverChildBuilderDelegate].
  ///
  /// {@macro flutter_widgetz.CustomDrawer}
  CustomDrawer.builder({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    this.color,
    this.header,
    this.semanticLabel,
  }) : delegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: header == null || false,
      child: Drawer(
        semanticLabel: semanticLabel,
        child: CustomScrollView(
          key: const PageStorageKey<int>(0),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _getHeader(context),
            ),
            SliverList(
              delegate: delegate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    if (header == null) {
      return const SizedBox.shrink();
    }

    final Color _color = color ?? Theme.of(context).colorScheme.primary;

    return DrawerHeader(
      decoration: BoxDecoration(
        color: _color,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: _color.blackOrWhite,
          fontSize: 24.0,
        ),
        child: header!,
      ),
    );
  }
}
