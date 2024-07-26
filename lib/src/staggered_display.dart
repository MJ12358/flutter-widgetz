part of flutter_widgetz;

class StaggeredDisplay extends StatefulWidget {
  const StaggeredDisplay({
    super.key,
    required this.children,
    this.initialDelay = const Duration(milliseconds: 50),
    this.childDelay = const Duration(milliseconds: 250),
    this.staggerDelay = const Duration(milliseconds: 50),
  });

  final List<Widget> children;
  final Duration initialDelay;
  final Duration childDelay;
  final Duration staggerDelay;

  @override
  State<StaggeredDisplay> createState() => _StaggeredDisplayState();
}

class _StaggeredDisplayState extends State<StaggeredDisplay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Duration _duration;
  late final Duration _initialDelay;
  late final Duration _childDelay;
  late final Duration _staggerDelay;
  final List<Interval> _intervals = <Interval>[];

  @override
  void initState() {
    super.initState();
    _initialDelay = widget.initialDelay;
    _childDelay = widget.childDelay;
    _staggerDelay = widget.staggerDelay;
    _duration = _initialDelay + (_staggerDelay * widget.children.length);
    _createIntervals(); // keep this above the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildChildren(),
    );
  }

  void _createIntervals() {
    for (int i = 0; i < widget.children.length; ++i) {
      final Duration startTime = _initialDelay + (_staggerDelay * i);
      final Duration endTime = startTime + _childDelay;
      _intervals.add(
        Interval(
          startTime.inMilliseconds / _duration.inMilliseconds,
          endTime.inMilliseconds / _duration.inMilliseconds,
        ),
      );
    }
  }

  List<Widget> _buildChildren() {
    final List<Widget> result = <Widget>[];
    for (int i = 0; i < widget.children.length; ++i) {
      result.add(
        _StaggeredChild(
          controller: _controller,
          interval: _intervals[i],
          child: widget.children[i],
        ),
      );
    }
    return result;
  }
}

class _StaggeredChild extends StatelessWidget {
  const _StaggeredChild({
    required this.child,
    required this.controller,
    required this.interval,
  });

  final Widget child;
  final AnimationController controller;
  final Interval interval;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, Widget? child) {
        final double percent = Curves.easeOut.transform(
          interval.transform(controller.value),
        );
        final double distance = (1.0 - percent) * 150;

        return Opacity(
          opacity: percent,
          child: Transform.translate(
            offset: Offset(distance, 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 16,
        ),
        child: child,
      ),
    );
  }
}
