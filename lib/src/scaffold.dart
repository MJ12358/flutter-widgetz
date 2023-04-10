part of flutter_widgetz;

/// {@template flutter_widgetz.CustomScaffold}
/// A [Scaffold] wrapped in [Semantics].
/// {@endtemplate}
class CustomScaffold extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomScaffold}
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.semanticLabel,
  }) : super(key: key);

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// The primary content of the scaffold.
  final Widget? body;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// A panel displayed to the side of the [body].
  final Widget? drawer;

  /// A button displayed floating above [body].
  final Widget? floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Creates a semantic annotation.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: body,
      ),
    );
  }
}
