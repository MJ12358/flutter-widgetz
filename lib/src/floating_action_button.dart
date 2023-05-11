part of flutter_widgetz;

/// {@template flutter_widgetz.CustomFloatingActionButton}
/// A [FloatingActionButton] that uses a [ScaleTransition]
/// when animating.
///
/// I use this to bring attention to the button when
/// the user needs to, for example, add a record when there are none.
/// {@endtemplate}
class CustomFloatingActionButton extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomFloatingActionButton}
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.duration = const Duration(seconds: 1),
    this.heroTag,
    this.icon = Icons.add,
    this.mini = false,
    this.shape,
    this.shouldAnimate = false,
    this.tooltip,
  });

  /// The callback that is called when the button is tapped.
  final VoidCallback onPressed;

  /// The length of time this animation should last.
  final Duration duration;

  /// The tag to apply to the button's [Hero] widget.
  final Object? heroTag;

  /// The icon shown in this button.
  final IconData icon;

  /// Controls the size of this button.
  final bool mini;

  /// The shape of the button's [Material].
  final ShapeBorder? shape;

  /// Determines if the button should animate.
  final bool shouldAnimate;

  /// Text that describes the action that will occur when the button is pressed.
  final String? tooltip;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Tween<double> _tween;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _tween = Tween<double>(
      begin: 0.9,
      end: 1.1,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldAnimate) {
      return ScaleTransition(
        scale: _tween.animate(_animationController),
        child: _getButton(),
      );
    }

    return _getButton();
  }

  Widget _getButton() {
    return FloatingActionButton(
      heroTag: widget.heroTag,
      mini: widget.mini,
      onPressed: widget.onPressed,
      shape: widget.shape,
      tooltip: widget.tooltip,
      child: Icon(widget.icon),
    );
  }
}
