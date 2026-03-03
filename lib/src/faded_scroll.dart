part of flutter_widgetz;

/// {@template flutter_widgetz.FadedScroll}
/// A widget that applies a fade effect to the edges of a scrollable child.
///
/// The fade effect is applied using a [ShaderMask] with a [LinearGradient]
/// that transitions from a specified fade color to transparent.
/// The amount of fading is determined by the scroll position of the child.
///
/// Inspired by https://pub.dev/packages/faded_scrollable
/// {@endtemplate}
class FadedScroll extends StatefulWidget {
  /// {@macro flutter_widgetz.FadedScroll}
  const FadedScroll({
    super.key,
    required this.child,
    this.axis = Axis.vertical,
    this.blendMode = BlendMode.dstOut,
    this.controller,
    this.scrollRatioStart = 0.0,
    this.scrollRatioEnd = 1.0,
    this.minStartRatioFade = 0.05,
    this.maxStartRatioFade = 0.175,
    this.minEndRatioFade = 0.05,
    this.maxEndRatioFade = 0.175,
    this.proportionalFade = true,
    this.fadeColor = Colors.white,
  })  : assert(
          scrollRatioStart >= 0 && scrollRatioStart <= 1,
          'scrollRatioStart must be between 0 and 1',
        ),
        assert(
          scrollRatioEnd >= 0 && scrollRatioEnd <= 1,
          'scrollRatioEnd must be between 0 and 1',
        ),
        assert(
          minStartRatioFade >= 0 && minStartRatioFade <= 1,
          'minStartRatioFade must be between 0 and 1',
        ),
        assert(
          maxStartRatioFade >= 0 && maxStartRatioFade <= 1,
          'maxStartRatioFade must be between 0 and 1',
        ),
        assert(
          minEndRatioFade >= 0 && minEndRatioFade <= 1,
          'minEndRatioFade must be between 0 and 1',
        ),
        assert(
          maxEndRatioFade >= 0 && maxEndRatioFade <= 1,
          'maxEndRatioFade must be between 0 and 1',
        ),
        assert(
          minStartRatioFade <= maxStartRatioFade,
          'minStartRatioFade must be less than or equal '
          'to maxStartRatioFade',
        ),
        assert(
          minEndRatioFade <= maxEndRatioFade,
          'minEndRatioFade must be less than or equal '
          'to maxEndRatioFade',
        );

  /// The widget that will be faded at the top and bottom.
  /// Either this widget or some of its children should be scrollable.
  ///
  /// When using [Axis.horizontal], the child should be wrapped in a
  /// [Builder] that provides use of [PrimaryScrollController.of(context)].
  final Widget child;

  /// The axis along which the child is scrollable.
  ///
  /// Defaults to [Axis.vertical].
  final Axis axis;

  /// The blend mode to use when applying the fade.
  ///
  /// Defaults to [BlendMode.dstOut].
  final BlendMode blendMode;

  /// An optional controller for the scrollable child. If not provided,
  /// a [ScrollController] will be created internally.
  final ScrollController? controller;

  /// Scroll ratio greater than this will cause top fade to appear.
  ///
  /// Defaults to 0.0.
  final double scrollRatioStart;

  /// Scroll ratio lower than this will cause top fade to appear.
  ///
  /// Defaults to 1.0.
  final double scrollRatioEnd;

  /// Minimum proportion of the screen that should be faded
  /// from the top of the screen.
  ///
  /// Defaults to 0.05.
  final double minStartRatioFade;

  /// Maximum proportion of the screen that should be faded
  /// from the top of the screen. A value of 0 means no fade.
  ///
  /// Defaults to 0.175.
  final double maxStartRatioFade;

  /// Minimum proportion of the screen that should be faded
  /// from the bottom of the screen. A value of 0 means no fade.
  ///
  /// Defaults to 0.05.
  final double minEndRatioFade;

  /// Maximum proportion of the screen that should be faded
  /// from the bottom of the screen. A value of 0 means no fade.
  ///
  /// Defaults to 0.175.
  final double maxEndRatioFade;

  /// Whether the fade amount should be proportional to the scroll ratio.
  ///
  /// Defaults to true.
  final bool proportionalFade;

  /// The color of the fade.
  ///
  /// Defaults to [Colors.white].
  final Color fadeColor;

  @override
  State<FadedScroll> createState() => _FadedScrollState();
}

class _FadedScrollState extends State<FadedScroll> {
  late final ScrollController _controller;

  double _scrollRatio = 0;
  bool _isScrollable = false;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = ScrollController();
      _ownsController = true;
    }
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollability();
    });
  }

  @override
  void didUpdateWidget(FadedScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollability();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) {
      return;
    }
    final ScrollPosition position = _controller.position;
    if (!_isScrollable || position.maxScrollExtent == 0) {
      return;
    }
    final double ratio = position.pixels / position.maxScrollExtent;
    // 1% opacity change threshold to prevent excessive rebuilds
    if ((ratio - _scrollRatio).abs() < 0.01) {
      return;
    }
    if (ratio != _scrollRatio) {
      setState(() {
        _scrollRatio = ratio;
      });
    }
  }

  void _updateScrollability() {
    if (!mounted || !_controller.hasClients) {
      return;
    }
    final ScrollPosition position = _controller.position;
    final bool scrollable = position.maxScrollExtent > 0;
    if (scrollable != _isScrollable) {
      setState(() {
        _isScrollable = scrollable;
        _scrollRatio =
            scrollable ? position.pixels / position.maxScrollExtent : 0;
      });
    }
  }

  (List<double>, List<Color>) _getGradientConfig() {
    if (!_isScrollable) {
      return (
        <double>[0.0, 1.0],
        <Color>[Colors.transparent, Colors.transparent],
      );
    }

    final double upperStop = widget.maxStartRatioFade;
    final double lowerStop = 1 - widget.maxEndRatioFade;

    final bool canFadeStart = _scrollRatio > widget.scrollRatioStart;
    final bool canFadeEnd = _scrollRatio < widget.scrollRatioEnd;
    final List<double> stops = <double>[];
    final List<Color> colors = <Color>[];

    if (canFadeStart) {
      stops.add(0);
      colors.add(widget.fadeColor);

      if (widget.proportionalFade) {
        stops.add(
          math.max(widget.minStartRatioFade, upperStop * _scrollRatio),
        );
      } else {
        stops.add(upperStop);
      }

      colors.add(Colors.transparent);
    }

    if (canFadeEnd) {
      if (widget.proportionalFade) {
        stops.add(
          math.min(
            1 - widget.minEndRatioFade,
            lowerStop + (1 - lowerStop) * _scrollRatio,
          ),
        );
      } else {
        stops.add(lowerStop);
      }

      colors.add(Colors.transparent);
      stops.add(1.0);
      colors.add(widget.fadeColor);
    }

    return (stops, colors);
  }

  Alignment _getStartAlignment() {
    switch (widget.axis) {
      case Axis.vertical:
        return Alignment.topCenter;
      case Axis.horizontal:
        return Alignment.centerLeft;
    }
  }

  Alignment _getEndAlignment() {
    switch (widget.axis) {
      case Axis.vertical:
        return Alignment.bottomCenter;
      case Axis.horizontal:
        return Alignment.centerRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (List<double> stops, List<Color> colors) = _getGradientConfig();

    return ShaderMask(
      blendMode: widget.blendMode,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: _getStartAlignment(),
          end: _getEndAlignment(),
          colors: colors,
          stops: stops,
        ).createShader(rect);
      },
      child: PrimaryScrollController(
        controller: _controller,
        child: widget.child,
      ),
    );
  }
}
