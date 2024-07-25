part of flutter_widgetz;

/// {@template flutter_widgetz.PercentIndicator}
/// A [ProgressIndicator] that shows the percentage overlayed.
///
///![PercentIndicator](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/percent_indicator.png)
/// {@endtemplate}
class PercentIndicator extends StatelessWidget {
  /// {@macro flutter_widgetz.PercentIndicator}
  PercentIndicator({
    super.key,
    required this.builder,
    required double value,
    this.borderRadius = _defaultBorderRadius,
    Widget? child,
    this.curve = _defaultCurve,
    this.duration = _defaultDuration,
    this.height = _defaultHeight,
    this.padding = _defaultPadding,
  })  : child = child ?? _defaultChild(value),
        value = _computeValue(value);

  /// This builds the progress indicator.
  final ValueWidgetBuilder<double> builder;

  /// The radii for each corner.
  final double borderRadius;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The curve to apply when animating.
  final Curve curve;

  /// The duration over which to animate.
  final Duration duration;

  /// The height of the indicator.
  final double height;

  /// The padding around the [child].
  final EdgeInsets padding;

  /// The value of this indicator.
  final double value;

  static const double _defaultBorderRadius = 0;
  static const Duration _defaultDuration = Duration(milliseconds: 500);
  static const Curve _defaultCurve = Curves.easeInOut;
  static const double _defaultHeight = 42.0;
  static const EdgeInsets _defaultPadding = EdgeInsets.all(4.0);
  static Widget _defaultChild(double value) {
    final double v = _computeValue(value) * 100;
    final RegExp regex = RegExp(r'([.]*0+)(?!.*\d)');
    final String result = v.toStringAsFixed(1).replaceAll(regex, '');
    return Text('$result%');
  }

  /// {@macro flutter_widgetz.PercentIndicator}
  ///
  /// Circular uses a [CircularProgressIndicator].
  PercentIndicator.circular({
    super.key,
    required double value,
    Color? backgroundColor,
    Color? color,
    this.curve = _defaultCurve,
    Widget? child,
    this.duration = _defaultDuration,
    this.height = _defaultHeight,
    this.padding = _defaultPadding,
    double strokeWidth = 16.0,
  })  : borderRadius = height * 3,
        builder = ((_, double value, __) {
          return SizedBox(
            height: height,
            width: height,
            child: CircularProgressIndicator(
              backgroundColor: backgroundColor,
              color: color,
              strokeWidth: strokeWidth,
              value: value,
            ),
          );
        }),
        child = child ?? _defaultChild(value),
        value = _computeValue(value);

  /// {@macro flutter_widgetz.PercentIndicator}
  ///
  /// Linear uses a [LinearProgressIndicator].
  PercentIndicator.linear({
    super.key,
    required double value,
    Color? backgroundColor,
    this.borderRadius = _defaultBorderRadius,
    Color? color,
    this.curve = _defaultCurve,
    Widget? child,
    this.duration = _defaultDuration,
    this.height = _defaultHeight,
    this.padding = _defaultPadding,
  })  : builder = ((_, double value, __) {
          return LinearProgressIndicator(
            backgroundColor: backgroundColor,
            color: color,
            minHeight: height,
            value: value,
          );
        }),
        child = child ?? _defaultChild(value),
        value = _computeValue(value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: TweenAnimationBuilder<double>(
                duration: duration,
                curve: curve,
                tween: Tween<double>(
                  begin: 0,
                  end: value,
                ),
                builder: builder,
              ),
            ),
          ),
          SizedBox.expand(
            child: Center(
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A helper to get a value that is between 0.0 and 1.0.
  static double _computeValue(double value) {
    if (value > 1.0) {
      return value / 100;
    }
    if (value < 0) {
      return 0.0;
    }
    return value;
  }
}
