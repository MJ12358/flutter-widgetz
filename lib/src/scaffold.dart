part of flutter_widgetz;

/// {@template flutter_widgetz.CustomScaffold}
/// A [Scaffold] wrapped in [Semantics] with a [SafeArea].
///
/// Also includes [PopScope] and a [RefreshIndicator]
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
    this.restorationId,
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

  /// Whether the floating action button should dynamically hide/show
  /// based on scroll notifications.
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

  /// Save and restore the state of the [Scaffold].
  final String? restorationId;

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
  late double _sheetHeight;
  late final GlobalKey _sheetKey;
  bool _showFab = true;

  bool get _canRefresh => widget.onRefresh != null;
  bool get _hasBottomSheet => widget.bottomSheet != null;

  @override
  void initState() {
    super.initState();
    _sheetHeight = 84.0; // default to a known good height
    _sheetKey = GlobalKey();

    if (!_hasBottomSheet) {
      return;
    }

    // get the height of the bottom sheet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double sheetHeight = _sheetKey.currentContext?.size?.height ?? 0;
      if (sheetHeight != _sheetHeight) {
        setState(() {
          _sheetHeight = sheetHeight;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: _hasBottomSheet
            ? _WidgetWrapper(
                key: _sheetKey,
                child: widget.bottomSheet!,
              )
            : null,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        floatingActionButton: _showFab ? widget.floatingActionButton : null,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        restorationId: widget.restorationId,
        body: NotificationListener<UserScrollNotification>(
          onNotification: _onScrollNotification,
          child: Builder(
            builder: (BuildContext context) {
              return PopScope(
                canPop: widget.onWillPop == null,
                onPopInvokedWithResult: (bool didPop, _) async {
                  await _onPopInvoked(context, didPop);
                },
                child: SafeArea(
                  bottom: widget.bottom && !_hasBottomSheet,
                  left: widget.left,
                  right: widget.right,
                  top: widget.top,
                  child: RefreshIndicator(
                    onRefresh:
                        widget.onRefresh ?? CustomScaffold._defaultOnRefresh,
                    notificationPredicate: (_) => _canRefresh,
                    child: Padding(
                      padding: widget.padding.copyWith(
                        bottom: _hasBottomSheet
                            ? _sheetHeight
                            : widget.padding.bottom,
                      ),
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
    if (axis != Axis.vertical) {
      return true;
    }
    if (direction == ScrollDirection.reverse) {
      setState(() {
        _showFab = false;
      });
    } else if (direction == ScrollDirection.forward) {
      setState(() {
        _showFab = true;
      });
    }
    return true;
  }

  Future<void> _onPopInvoked(BuildContext context, bool didPop) async {
    if (didPop) {
      Scaffold.of(context).closeDrawer();
      ScaffoldMessenger.of(context).clearMaterialBanners();
      ScaffoldMessenger.of(context).clearSnackBars();
      return;
    }
    // Pop was prevented, check if we should allow it
    if (widget.onWillPop != null) {
      final bool shouldPop = await widget.onWillPop!();
      if (shouldPop && context.mounted) {
        // Trigger pop again
        Navigator.of(context).pop();
      }
    }
  }
}

class _WidgetWrapper extends StatelessWidget {
  const _WidgetWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
