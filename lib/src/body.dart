part of flutter_widgetz;

/// {@template flutter_widgetz.CustomBody}
/// Wraps child in a safe area, layout builder and single child scroll view.
///
/// Using a constrained box with the parents height and infinity width.
/// {@endtemplate}
class CustomBody extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomBody}
  const CustomBody({
    Key? key,
    this.padding,
    this.physics = const RangeMaintainingScrollPhysics(),
    this.onRefresh,
    this.onWillPop,
    required this.child,
  }) : super(key: key);

  /// Empty space to inscribe inside the `Container`.
  final EdgeInsets? padding;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// A function that's called when the user has dragged
  /// far enough to demonstrate that they want the app to refresh
  final AsyncCallback? onRefresh;

  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  final AsyncValueGetter<bool>? onWillPop;

  /// The [child] contained by the container.
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
