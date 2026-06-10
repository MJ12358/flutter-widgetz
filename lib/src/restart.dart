part of '../flutter_widgetz.dart';

/// {@template flutter_widgetz.RestartWidget}
/// Restart Widget
///
/// Inspired By: https://stackoverflow.com/a/50116077/9111447
/// {@endtemplate}
class RestartWidget extends StatefulWidget {
  /// {@macro flutter_widgetz.RestartWidget}
  const RestartWidget({
    super.key,
    required this.child,
  });

  /// The child widget to restart.
  final Widget child;

  /// Restarts the widget tree.
  static void restart(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restart();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restart() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
