part of flutter_widgetz;

/// {@template flutter_widgetz.CustomProgressIndicator}
/// Wraps a [ProgressIndicator] in a [Center].
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
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : indicator = CircularProgressIndicator(
          semanticsLabel: semanticsLabel,
          value: value,
        );

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Linear uses a [LinearProgressIndicator].
  CustomProgressIndicator.linear({
    super.key,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : indicator = LinearProgressIndicator(
          borderRadius: borderRadius,
          semanticsLabel: semanticsLabel,
          value: value,
        );

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Refresh uses a [RefreshProgressIndicator].
  CustomProgressIndicator.refresh({
    super.key,
    String semanticsLabel = _defaultSemanticsLabel,
    double? value,
  }) : indicator = RefreshProgressIndicator(
          semanticsLabel: semanticsLabel,
          value: value,
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: indicator,
    );
  }
}
