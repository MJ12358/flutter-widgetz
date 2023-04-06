part of flutter_widgetz;

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.body,
    this.semanticLabel,
  }) : super(key: key);

  final AppBar? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? body;
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
