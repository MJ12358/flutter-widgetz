part of flutter_widgetz;

/// {@template flutter_widgetz.FlavorBanner}
/// A convinience widget that wraps [Banner] with some defaults.
/// {@endtemplate}
class FlavorBanner extends StatelessWidget {
  /// {@macro flutter_widgetz.FlavorBanner}
  const FlavorBanner({
    super.key,
    required this.message,
    this.color = const Color(0xA0B71C1C),
    this.location = BannerLocation.topStart,
    this.child = const SizedBox.shrink(),
  });

  final String message;
  final Color color;
  final BannerLocation location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: message,
        location: location,
        color: color,
        textStyle: TextStyle(
          color: color.blackOrWhite,
          fontSize: 12.0 * 0.85,
          fontWeight: FontWeight.w900,
          height: 1.0,
        ),
        child: child,
      ),
    );
  }
}
