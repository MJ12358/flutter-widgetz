part of flutter_widgetz;

/// A [Scaffold] wrapped in [Semantics].
class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.body,
    this.semanticLabel,
  }) : super(key: key);

  /// An app bar to display at the top of the scaffold.
  final AppBar? appBar;

  /// A panel displayed to the side of the [body].
  final Widget? drawer;

  /// A button displayed floating above [body].
  final Widget? floatingActionButton;

  /// The primary content of the scaffold.
  final Widget? body;

  /// Creates a semantic annotation.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: Scaffold(
        appBar: appBar,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        body: body,
      ),
    );
  }
}
