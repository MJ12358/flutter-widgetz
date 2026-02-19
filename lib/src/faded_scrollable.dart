part of flutter_widgetz;

/// {@template flutter_widgetz.FadedScrollable}
/// A widget that applies a fade effect to the edges of a scrollable child.
///
/// The fade effect is applied using a [ShaderMask] with a [LinearGradient]
/// that transitions from a specified fade color to transparent.
/// The amount of fading is determined by the scroll position of the child.
///
/// Inspired by https://pub.dev/packages/faded_scrollable
/// {@endtemplate}
class FadedScrollable extends StatefulWidget {
  /// {@macro flutter_widgetz.FadedScrollable}
  const FadedScrollable({
    super.key,
    required this.child,
    this.axis = Axis.vertical,
    this.blendMode = BlendMode.dstOut,
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
  final Widget child;

  /// The axis along which the child is scrollable.
  ///
  /// Defaults to [Axis.vertical].
  final Axis axis;

  /// The blend mode to use when applying the fade.
  ///
  /// Defaults to [BlendMode.dstOut].
  final BlendMode blendMode;

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
  State<FadedScrollable> createState() => _FadedScrollableState();
}

class _FadedScrollableState extends State<FadedScrollable> {
  double scrollRatio = 0;
  Timer? _debounceTimer;

  /// The duration to debounce scroll notifications.
  /// This is set to 8ms, which is twice every frame at 60fps.
  final Duration _debounceDuration = const Duration(milliseconds: 8);

  (List<double>, List<Color>) _getGradientConfig() {
    final double upperStop = widget.maxStartRatioFade;
    final double lowerStop = 1 - widget.maxEndRatioFade;

    final bool canFadeStart = scrollRatio > widget.scrollRatioStart;
    final bool canFadeEnd = scrollRatio < widget.scrollRatioEnd;
    final List<double> stops = <double>[];
    final List<Color> colors = <Color>[];

    if (canFadeStart) {
      stops.add(0);
      colors.add(widget.fadeColor);

      if (widget.proportionalFade) {
        stops.add(
          math.max(widget.minStartRatioFade, upperStop * scrollRatio),
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
            lowerStop + (1 - lowerStop) * scrollRatio,
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

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // Cancel any existing timer
      _debounceTimer?.cancel();

      // Start a new timer
      _debounceTimer = Timer(_debounceDuration, () {
        setState(() {
          final double currentScroll = notification.metrics.pixels;
          final double maxScroll = notification.metrics.maxScrollExtent;
          if (maxScroll > 0) {
            scrollRatio = currentScroll / maxScroll;
          } else {
            scrollRatio = 0;
          }
        });
      });
    }
    return false; // Important: Don't consume the notification
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (List<double> stops, List<Color> colors) = _getGradientConfig();

    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: _getStartAlignment(),
            end: _getEndAlignment(),
            colors: colors,
            stops: stops,
          ).createShader(rect);
        },
        blendMode: widget.blendMode,
        child: widget.child,
      ),
    );
  }
}
