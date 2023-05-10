part of flutter_widgetz;

/// {@template flutter_widgetz.Carousel}
/// A carousel of widgets.
///
/// https://stackoverflow.com/questions/49161719/is-there-a-way-to-have-an-infinite-loop-using-pageview-in-flutter
/// {@endtemplate}
class Carousel extends StatefulWidget {
  /// Determines whether or not to automatically scroll this [PageView].
  final bool autoplay;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// A controller for [PageView].
  final PageController? controller;

  /// A parametric animation easing curve.
  final Curve curve;

  /// A delegate that provides the children for the [PageView].
  final SliverChildDelegate delegate;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int>? onChanged;

  /// The duration the page is presented on the screen.
  final Duration pageDuration;

  /// How the page view should respond to user input.
  final ScrollPhysics? physics;

  /// The axis along which the page view scrolls.
  final Axis scrollDirection;

  /// The duration the transition between screens lasts.
  final Duration transitionDuration;

  static const bool _defaultAutoPlay = false;
  static const Clip _defaultClipBehavior = Clip.hardEdge;
  static const Curve _defaultCurve = Curves.fastOutSlowIn;
  static const Duration _defaultPageDuration = Duration(seconds: 7);
  static const Axis _defaultScrollDirection = Axis.horizontal;
  static const Duration _defaultTransitionDuration = Duration(seconds: 1);

  /// {@macro flutter_widgetz.Carousel}
  Carousel.count({
    super.key,
    required List<Widget> children,
    this.autoplay = _defaultAutoPlay,
    this.clipBehavior = _defaultClipBehavior,
    this.controller,
    this.curve = _defaultCurve,
    this.pageDuration = _defaultPageDuration,
    this.onChanged,
    this.physics,
    this.scrollDirection = _defaultScrollDirection,
    this.transitionDuration = _defaultTransitionDuration,
  }) : delegate = SliverChildListDelegate(
          children,
        );

  /// {@macro flutter_widgetz.Carousel}
  Carousel.builder({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    this.autoplay = _defaultAutoPlay,
    this.clipBehavior = _defaultClipBehavior,
    this.controller,
    this.curve = _defaultCurve,
    this.pageDuration = _defaultPageDuration,
    this.onChanged,
    this.physics,
    this.scrollDirection = _defaultScrollDirection,
    this.transitionDuration = _defaultTransitionDuration,
  }) : delegate = SliverChildBuilderDelegate((BuildContext context, int index) {
          final int page = index % itemCount;
          return itemBuilder.call(context, page);
        });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _controller;
  late int _currentPage;
  late bool _isReverse;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? PageController();
    _currentPage = 0;
    _isReverse = false;

    if (widget.autoplay) {
      _initTimer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: _onNotification,
      child: PageView.custom(
        clipBehavior: widget.clipBehavior,
        controller: _controller,
        childrenDelegate: widget.delegate,
        onPageChanged: _onPageChanged,
        physics: widget.physics,
        reverse: _isReverse,
        scrollDirection: widget.scrollDirection,
      ),
    );
  }

  bool _onNotification(UserScrollNotification notification) {
    final ScrollDirection direction = notification.direction;

    if (_isReverse && _currentPage == 0) {
      if (direction == ScrollDirection.forward) {
        _isReverse = false;
      }
    } else if (_currentPage == 0) {
      if (direction == ScrollDirection.forward) {
        _isReverse = true;
      }
    }

    setState(() {
      _isReverse = _isReverse;
    });

    return true;
  }

  void _onPageChanged(int page) {
    _currentPage = page;
    widget.onChanged?.call(page);
  }

  void _initTimer() {
    _timer = Timer.periodic(
      widget.pageDuration,
      (_) {
        _controller.nextPage(
          duration: widget.transitionDuration,
          curve: widget.curve,
        );
      },
    );
  }
}
