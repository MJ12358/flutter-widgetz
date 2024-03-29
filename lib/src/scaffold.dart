part of flutter_widgetz;

/// {@template flutter_widgetz.CustomScaffold}
/// A [Scaffold] wrapped in [Semantics] with a [SafeArea].
///
/// Also includes [WillPopScope] and a [RefreshIndicator]
/// to be used when necessary.
/// {@endtemplate}
class CustomScaffold extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomScaffold}
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottom = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.left = true,
    this.onRefresh,
    this.onWillPop,
    this.padding = EdgeInsets.zero,
    this.resizeToAvoidBottomInset = true,
    this.right = true,
    this.semanticLabel,
    this.top = false,
  });

  /// The primary content of the scaffold.
  final Widget body;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// The persistent bottom sheet to display.
  final Widget? bottomSheet;

  /// A panel displayed to the side of the [body].
  final Widget? drawer;

  /// A panel displayed to the side of the [body].
  final Widget? endDrawer;

  /// A button displayed floating above [body].
  final Widget? floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// A function that's called when the user has dragged
  /// far enough to demonstrate that they want the app to refresh
  final AsyncCallback? onRefresh;

  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  final AsyncValueGetter<bool>? onWillPop;

  /// Empty space around the [body].
  final EdgeInsets padding;

  /// If true the [body] and floating widgets avoid the onscreen keyboard.
  final bool resizeToAvoidBottomInset;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  /// Creates a semantic annotation.
  final String? semanticLabel;

  /// Whether to avoid system intrusions at the top of the screen,
  /// typically the system status bar.
  final bool top;

  static Future<void> _defaultOnRefresh() async {}

  bool get _canRefresh => onRefresh != null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        drawer: drawer,
        endDrawer: endDrawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: Builder(
          builder: (BuildContext context) {
            // TODO: 'WillPopScope' is depreciated but requires Flutter >= 3.16
            return WillPopScope(
              onWillPop: () => _onWillPop(context),
              child: SafeArea(
                bottom: bottom,
                left: left,
                right: right,
                top: top,
                child: RefreshIndicator(
                  onRefresh: onRefresh ?? _defaultOnRefresh,
                  notificationPredicate: (_) => _canRefresh,
                  child: Padding(
                    padding: padding,
                    child: body,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (onWillPop != null) {
      return onWillPop!();
    }
    Scaffold.of(context).closeDrawer();
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).clearSnackBars();
    return true;
  }
}
