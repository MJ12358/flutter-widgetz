part of flutter_widgetz;

/// {@template flutter_widgetz.CustomScaffold}
/// A [Scaffold] wrapped in [Semantics] with a [SafeArea].
///
/// Also includes [WillPopScope] and a [RefreshIndicator]
/// to be used when necessary.
/// {@endtemplate}
class CustomScaffold extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomScaffold}
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottom = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.dynamicFab = false,
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

  final bool dynamicFab;

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

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool get _canRefresh => widget.onRefresh != null;
  bool _showFab = true;

  @override
  Widget build(BuildContext context) {
    // TODO: possibly add a sticky bottom sheet in here...
    //
    return Semantics(
      label: widget.semanticLabel,
      child: Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        floatingActionButton: _showFab ? widget.floatingActionButton : null,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        body: NotificationListener<UserScrollNotification>(
          onNotification: _onScrollNotification,
          child: Builder(
            builder: (BuildContext context) {
              // TODO: 'WillPopScope' is depreciated
              // but requires Flutter >= 3.16
              return WillPopScope(
                onWillPop: () => _onWillPop(context),
                child: SafeArea(
                  bottom: widget.bottom,
                  left: widget.left,
                  right: widget.right,
                  top: widget.top,
                  child: RefreshIndicator(
                    onRefresh:
                        widget.onRefresh ?? CustomScaffold._defaultOnRefresh,
                    notificationPredicate: (_) => _canRefresh,
                    child: Padding(
                      padding: widget.padding,
                      child: widget.body,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _onScrollNotification(UserScrollNotification notification) {
    if (!widget.dynamicFab) {
      return true;
    }
    final ScrollDirection direction = notification.direction;
    final Axis axis = axisDirectionToAxis(notification.metrics.axisDirection);
    if (axis == Axis.vertical) {
      if (direction == ScrollDirection.reverse) {
        setState(() {
          _showFab = false;
        });
      } else if (direction == ScrollDirection.forward) {
        setState(() {
          _showFab = true;
        });
      }
    }
    return true;
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (widget.onWillPop != null) {
      return widget.onWillPop!();
    }
    Scaffold.of(context).closeDrawer();
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).clearSnackBars();
    return true;
  }
}
