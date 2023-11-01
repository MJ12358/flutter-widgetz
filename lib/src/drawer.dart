part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDrawer}
/// A [Drawer] that uses a [CustomScrollView].
/// {@endtemplate}
class CustomDrawer extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDrawer}
  const CustomDrawer({
    super.key,
    required this.delegate,
    this.color,
    this.header,
  });

  /// A delegate that provides the children for the [PageView].
  final SliverChildDelegate delegate;

  /// The background color applied to the [header].
  final Color? color;

  /// A widget to be placed inside the drawer header.
  final Widget? header;

  /// {@macro flutter_widgetz.CustomDrawer}
  ///
  /// Count uses [SliverChildListDelegate].
  CustomDrawer.count({
    super.key,
    required List<Widget> children,
    this.color,
    this.header,
  }) : delegate = SliverChildListDelegate(
          children,
        );

  /// {@macro flutter_widgetz.CustomDrawer}
  ///
  /// Builder uses [SliverChildBuilderDelegate].
  CustomDrawer.builder({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    this.color,
    this.header,
  }) : delegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: header == null || false,
      child: Drawer(
        child: CustomScrollView(
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
      return const SizedBox();
    }

    return DrawerHeader(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: header,
    );
  }
}
