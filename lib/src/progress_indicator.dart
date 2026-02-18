part of flutter_widgetz;

/// {@template flutter_widgetz.CustomProgressIndicator}
/// Wraps a [ProgressIndicator] in a [Center].
///
///![CustomProgressIndicator](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/progress_indicator.png)
/// {@endtemplate}
class CustomProgressIndicator extends StatelessWidget {
  /// The child to be shown.
  final Widget _child;

  static const String _defaultSemanticsLabel = 'Loading';

  /// Circular uses a [CircularProgressIndicator].
  ///
  /// {@macro flutter_widgetz.CustomProgressIndicator}
  CustomProgressIndicator.circular({
    super.key,
    Color? backgroundColor,
    Color? color,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : _child = CircularProgressIndicator(
          backgroundColor: backgroundColor,
          color: color,
          semanticsLabel: semanticsLabel,
          value: _computeValue(value),
        );

  /// Linear uses a [LinearProgressIndicator].
  ///
  /// {@macro flutter_widgetz.CustomProgressIndicator}
  CustomProgressIndicator.linear({
    super.key,
    Color? backgroundColor,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? color,
    double? minHeight,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : _child = LinearProgressIndicator(
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          color: color,
          minHeight: minHeight,
          semanticsLabel: semanticsLabel,
          value: _computeValue(value),
        );

  /// Positioned uses a [Positioned] with a [ProgressIndicator].
  ///
  /// {@macro flutter_widgetz.CustomProgressIndicator}
  CustomProgressIndicator.positioned({
    super.key,
    double? bottom,
    double? left,
    double? right,
    double? top,
    ProgressIndicator indicator = const LinearProgressIndicator(),
  }) : _child = Positioned(
          bottom: bottom,
          left: left,
          right: right,
          top: top,
          child: indicator,
        );

  /// Refresh uses a [RefreshProgressIndicator].
  ///
  /// {@macro flutter_widgetz.CustomProgressIndicator}
  CustomProgressIndicator.refresh({
    super.key,
    Color? backgroundColor,
    Color? color,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : _child = RefreshProgressIndicator(
          backgroundColor: backgroundColor,
          color: color,
          semanticsLabel: semanticsLabel,
          value: _computeValue(value),
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _child,
    );
  }

  // A helper to get a value that is between 0.0 and 1.0.
  static double? _computeValue(double? value) {
    if (value == null) {
      return value;
    }
    if (value > 1.0) {
      return value / 100;
    }
    if (value < 0) {
      return 0.0;
    }
    return value;
  }
}
