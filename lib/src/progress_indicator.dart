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

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Circular uses a [CircularProgressIndicator].
  const CustomProgressIndicator.circular({
    super.key,
  }) : indicator = const CircularProgressIndicator();

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Linear uses a [LinearProgressIndicator].
  const CustomProgressIndicator.linear({
    super.key,
  }) : indicator = const LinearProgressIndicator();

  /// {@macro flutter_widgetz.CustomProgressIndicator}
  ///
  /// Refresh uses a [RefreshProgressIndicator].
  const CustomProgressIndicator.refresh({
    super.key,
  }) : indicator = const RefreshProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: indicator,
    );
  }
}
