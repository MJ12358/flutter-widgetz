part of flutter_widgetz;

/// {@template flutter_widgetz.CustomProgressIndicator}
/// Wraps a [ProgressIndicator] in a [Center].
///
///![CustomProgressIndicator](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/progress_indicator.png)
/// {@endtemplate}
class CustomProgressIndicator extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomProgressIndicator}
  const CustomProgressIndicator({
    super.key,
    required this.indicator,
  });

  /// The progress indicator to be shown.
  final ProgressIndicator indicator;

  static const String _defaultSemanticsLabel = 'Loading';

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Circular uses a [CircularProgressIndicator].
  CustomProgressIndicator.circular({
    super.key,
    Color? backgroundColor,
    Color? color,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : indicator = CircularProgressIndicator(
          backgroundColor: backgroundColor,
          color: color,
          semanticsLabel: semanticsLabel,
          value: _computeValue(value),
        );

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Linear uses a [LinearProgressIndicator].
  CustomProgressIndicator.linear({
    super.key,
    Color? backgroundColor,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? color,
    double? minHeight,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : indicator = LinearProgressIndicator(
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          color: color,
          minHeight: minHeight,
          semanticsLabel: semanticsLabel,
          value: _computeValue(value),
        );

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Refresh uses a [RefreshProgressIndicator].
  CustomProgressIndicator.refresh({
    super.key,
    Color? backgroundColor,
    Color? color,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : indicator = RefreshProgressIndicator(
          backgroundColor: backgroundColor,
          color: color,
          semanticsLabel: semanticsLabel,
          value: _computeValue(value),
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: indicator,
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
