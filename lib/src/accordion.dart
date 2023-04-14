part of flutter_widgetz;

/// {@template flutter_widgetz.Accordion}
/// An accordion allows a user to toggle the display of a section of content.
/// {@endtemplate}
class Accordion extends StatefulWidget {
  /// {@macro flutter_widgetz.Accordion}
  const Accordion({
    Key? key,
    this.child = const SizedBox(),
    this.duration = const Duration(milliseconds: 300),
    this.isOpen = false,
    this.onTap,
    this.title = '',
  }) : super(key: key);

  /// The content displayed when the accordion is open.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// Whether the accordion is open.
  final bool isOpen;

  /// Called when the header is tapped.
  final ValueChanged<bool>? onTap;

  /// The text to display in the header.
  final String title;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: _handleTap,
          child: Row(
            children: <Widget>[
              AnimatedRotation(
                turns: _isOpen ? 0.25 : 0,
                duration: widget.duration,
                child: const Icon(Icons.keyboard_arrow_right),
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: _animation,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: widget.child,
          ),
        ),
      ],
    );
  }

  void _handleTap() {
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
