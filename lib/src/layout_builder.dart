part of flutter_widgetz;

/// {@template flutter_widgetz.CustomLayoutBuilder}
/// A [LayoutBuilder] that builds different widgets
/// based on constraints.
/// {@endtemplate}
class CustomLayoutBuilder extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomLayoutBuilder}
  const CustomLayoutBuilder({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    this.mobileBreakpoint = 500,
    this.tabletBreakpoint = 1100,
  });

  /// Builds a widget to be used when constraints
  /// are less than [mobileBreakpoint].
  final WidgetBuilder mobileBuilder;

  /// Builds a widget to be used when constraints
  /// are less than [tabletBreakpoint].
  final WidgetBuilder tabletBuilder;

  /// Builds a wiget to be used when constraints
  /// are greater than [tabletBreakpoint].
  final WidgetBuilder desktopBuilder;

  /// The max width used to determine a mobile device.
  final int mobileBreakpoint;

  /// The max width used to determine a tablet device.
  final int tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return mobileBuilder(context);
        } else if (constraints.maxWidth < tabletBreakpoint) {
          return tabletBuilder(context);
        } else {
          return desktopBuilder(context);
        }
      },
    );
  }
}
