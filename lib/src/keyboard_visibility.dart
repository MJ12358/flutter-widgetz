part of flutter_widgetz;

/// {@template flutter_widgetz.KeyboardVisibilityBuilder}
/// Calls [listener] on keyboard close/open.
///
/// https://stackoverflow.com/a/63241409/1321917
///
/// https://stackoverflow.com/questions/48085203/flutter-keyboard-listen-on-hide-and-show
/// {@endtemplate}
class KeyboardVisibility extends StatefulWidget {
  /// {@macro flutter_widgetz.KeyboardVisibilityBuilder}
  const KeyboardVisibility({
    super.key,
    required this.child,
    required this.listener,
  });

  final Widget child;
  final Function(
    bool isKeyboardVisible,
  ) listener;

  @override
  _KeyboardVisibilityState createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final double bottomInset = View.of(context).viewInsets.bottom;
    final bool value = bottomInset > 0.0;
    if (value != _isKeyboardVisible) {
      _isKeyboardVisible = value;
      widget.listener.call(_isKeyboardVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
