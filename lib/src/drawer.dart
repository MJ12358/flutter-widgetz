part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDrawer}
/// A [Drawer] that uses a [CustomScrollView].
/// {@endtemplate}
class CustomDrawer extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDrawer}
  const CustomDrawer({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.header,
  }) : super(key: key);

  /// The total number of children this delegate can provide.
  final int itemCount;

  /// Called to build children for the sliver.
  final Widget Function(BuildContext, int) itemBuilder;

  /// A widget to be placed inside the drawer header.
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _getHeader(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              itemBuilder,
              childCount: itemCount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    if (header == null) {
      return const SizedBox();
    }

    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: header,
    );
  }
}
