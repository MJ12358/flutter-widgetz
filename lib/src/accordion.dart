part of flutter_widgetz;

/// {@template flutter_widgetz.Accordion}
/// An accordion allows a user to toggle the display of a section of content.
///
///![Accordion](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/accordion.png)
/// {@endtemplate}
class Accordion extends StatefulWidget {
  /// {@macro flutter_widgetz.Accordion}
  const Accordion({
    super.key,
    this.child = const SizedBox.shrink(),
    this.childPadding = const EdgeInsets.all(8.0),
    this.duration = kThemeChangeDuration,
    this.isOpen = false,
    this.onTap,
    this.title = const Text(''),
    this.titlePadding = const EdgeInsets.all(8.0),
  });

  /// The content displayed when the accordion is open.
  final Widget child;

  /// The padding insetting the child.
  final EdgeInsets childPadding;

  /// The duration of the animation.
  final Duration duration;

  /// Whether the accordion is open.
  final bool isOpen;

  /// Called when the header is tapped.
  final ValueChanged<bool>? onTap;

  /// The widget to display in the header.
  final Widget title;

  /// The padding around the title.
  final EdgeInsets titlePadding;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> with TickerProviderStateMixin {
  late bool _isOpen;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _isOpen = widget.isOpen;

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    if (_isOpen) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: _onTap,
          child: Padding(
            padding: widget.titlePadding,
            child: Row(
              children: <Widget>[
                AnimatedRotation(
                  turns: _isOpen ? 0.25 : 0,
                  duration: widget.duration,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: theme.scaffoldBackgroundColor.blackOrWhite,
                  ),
                ),
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                    child: widget.title,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: _animation,
          child: Container(
            padding: widget.childPadding,
            child: widget.child,
          ),
        ),
      ],
    );
  }

  void _onTap() {
    setState(() {
      _isOpen = !_isOpen;
    });

    widget.onTap?.call(_isOpen);

    if (_isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
