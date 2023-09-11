part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAvatar}
/// Uses [CircleAvatar] while dumping image errors.
///
/// Images are show via `foregroundImage`.
/// {@endtemplate}
class CustomAvatar extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomAvatar}
  const CustomAvatar({
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = null;

  /// The color with which to fill the circle.
  final Color? color;

  /// The icon to display when no image is present.
  final IconData icon;

  /// The image provider.
  final ImageProvider? imageProvider;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double? radius;

  static const IconData _defaultIcon = Icons.person;
  static void _defaultImageErrorHandler(Object o, StackTrace? s) {}
  static Widget _defaultImageErrorWidgetHandler(
    BuildContext c,
    Object o,
    StackTrace? s,
  ) {
    return const SizedBox();
  }

  /// {@macro flutter_widgetz.CustomAvatar}
  ///
  /// Uses an [AssetImage].
  CustomAvatar.asset(
    String name, {
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = Image.asset(
          name,
          errorBuilder: _defaultImageErrorWidgetHandler,
        ).image;

  /// {@macro flutter_widgetz.CustomAvatar}
  ///
  /// Uses a [MemoryImage].
  CustomAvatar.memory(
    Uint8List bytes, {
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = Image.memory(
          bytes,
          errorBuilder: _defaultImageErrorWidgetHandler,
        ).image;

  /// {@macro flutter_widgetz.CustomAvatar}
  ///
  /// Uses a [NetworkImage].
  CustomAvatar.network(
    String src, {
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = Image.network(
          src,
          errorBuilder: _defaultImageErrorWidgetHandler,
        ).image;

  bool get _hasImage => imageProvider != null;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _hasImage ? null : color,
      foregroundImage: imageProvider,
      onForegroundImageError: _hasImage ? _defaultImageErrorHandler : null,
      radius: radius,
      child: Center(
        child: Icon(icon),
      ),
    );
  }
}
