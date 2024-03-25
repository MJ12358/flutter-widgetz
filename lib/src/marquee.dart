part of flutter_widgetz;

/// {@template flutter_widgetz.Marquee}
/// A widget that scrolls a [child] infinitely.
/// {@endtemplate}
class Marquee extends StatefulWidget {
  /// {@macro flutter_widgetz.Marquee}
  const Marquee({
    super.key,
    required this.child,
    this.curve = Curves.ease,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(seconds: 6),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(seconds: 1),
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The animation easing curve.
  final Curve curve;

  /// The direction of scrolling.
  final Axis direction;

  /// The duration of the scrolling animation.
  final Duration animationDuration;

  /// The duration of the back animation.
  final Duration backDuration;

  /// The duration of the pause between animations.
  final Duration pauseDuration;

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(_scroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scroll(_) async {
    while (_scrollController.hasClients) {
      await Future<void>.delayed(widget.pauseDuration);
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: widget.curve,
        );
      }
      await Future<void>.delayed(widget.pauseDuration);
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: widget.curve,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: widget.direction,
      child: widget.child,
    );
  }
}
