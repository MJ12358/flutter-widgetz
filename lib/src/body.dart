part of flutter_widgetz;

/// Wraps child in a safe area, layout builder and single child scroll view.
///
/// Using a constrained box with the parents height and infinity width.
class CustomBody extends StatelessWidget {
  const CustomBody({
    Key? key,
    this.padding,
    this.physics = const RangeMaintainingScrollPhysics(),
    this.onRefresh,
    this.onWillPop,
    required this.child,
  }) : super(key: key);

  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final AsyncCallback? onRefresh;
  final AsyncValueGetter<bool>? onWillPop;
  final Widget child;

  static Future<void> _defaultOnRefresh() async {}

  bool get _canRefresh => onRefresh != null;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return RefreshIndicator(
              onRefresh: onRefresh ?? _defaultOnRefresh,
              notificationPredicate: (_) => _canRefresh,
              child: SingleChildScrollView(
                physics: physics,
                child: ConstrainedBox(
                  constraints: constraints.copyWith(
                    minHeight: constraints.maxHeight,
                    maxHeight: double.infinity,
                  ),
                  child: Container(
                    padding: padding,
                    width: double.infinity,
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      onWillPop: () async {
        if (onWillPop != null) {
          return onWillPop!();
        }
        Scaffold.of(context).closeDrawer();
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ScaffoldMessenger.of(context).clearSnackBars();
        return true;
      },
    );
  }
}
