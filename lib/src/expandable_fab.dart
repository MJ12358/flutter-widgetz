part of flutter_widgetz;

/// {@template flutter_widgetz.ExpandableFab}
/// When pressed, this expandable FAB spawns multiple, other action buttons.
///
/// https://docs.flutter.dev/cookbook/effects/expandable-fab
/// {@endtemplate}
class ExpandableFab extends StatefulWidget {
  /// {@macro flutter_widgetz.ExpandableFab}
  const ExpandableFab({
    super.key,
    required this.children,
    this.initialOpen = false,
    this.distance = 112.0,
    this.duration = const Duration(milliseconds: 250),
    this.closedIcon = const Icon(Icons.create),
    this.openedIcon = const Icon(Icons.close),
  });

  /// The widgets shown when the fab is open.
  ///
  /// Typically a list of [ExpandedActionButton].
  final List<Widget> children;

  /// Determines whether this action button is initially open or not.
  final bool initialOpen;

  /// The distance the [children] are when opened.
  final double distance;

  /// The duration of the open/close animations.
  final Duration duration;

  /// The icon shown when the fab is closed.
  final Icon closedIcon;

  /// The icon show when the fab is opened.
  final Icon openedIcon;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late bool _isOpen;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initialOpen;
    _controller = AnimationController(
      value: _isOpen ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _close() {
    if (_isOpen) {
      setState(() {
        _isOpen = false;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      // close the fab when tapped outside
      onTapOutside: (_) => _close(),
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: <Widget>[
            _OpenedFab(
              icon: widget.openedIcon,
              onTap: _toggle,
            ),
            ..._buildExpandingActionButtons(),
            _ClosedFab(
              duration: widget.duration,
              icon: widget.closedIcon,
              isOpen: _isOpen,
              onTap: _toggle,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final List<Widget> children = <Widget>[];
    final int count = widget.children.length;
    final double step = 90.0 / (count - 1);
    double angleInDegrees = 0.0;
    for (int i = 0; i < count; i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}

class _OpenedFab extends StatelessWidget {
  const _OpenedFab({
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = theme.brightness;

    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          // this is to account for a dark theme
          color: brightness == Brightness.dark
              ? theme.colorScheme.onBackground
              : null,
          elevation: 4.0,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconTheme(
                data: theme.iconTheme.copyWith(
                  color: theme.primaryColor,
                ),
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ClosedFab extends StatelessWidget {
  const _ClosedFab({
    required this.duration,
    required this.icon,
    required this.isOpen,
    required this.onTap,
  });

  final Duration duration;
  final Widget icon;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isOpen,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          isOpen ? 0.7 : 1.0,
          isOpen ? 0.7 : 1.0,
          1.0,
        ),
        duration: duration,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: isOpen ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: duration,
          child: FloatingActionButton(
            onPressed: onTap,
            child: icon,
          ),
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (BuildContext context, Widget? child) {
        final Offset offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

/// {@template flutter_widgetz.ExpandedActionButton}
/// A convenience widget for populating the
/// [ExpandableFab]'s children.
/// {@endtemplate}
class ExpandedActionButton extends StatelessWidget {
  /// {@macro flutter_widgetz.ExpandedActionButton}
  const ExpandedActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.clipBehavior = Clip.antiAlias,
    this.elevation = 4.0,
    this.shape = const CircleBorder(),
    this.tooltip,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final Clip clipBehavior;
  final double elevation;
  final ShapeBorder shape;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      shape: shape,
      clipBehavior: clipBehavior,
      color: theme.colorScheme.secondary,
      elevation: elevation,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
