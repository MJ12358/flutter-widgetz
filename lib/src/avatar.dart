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
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = null;

  /// The icon to display when no image is present.
  final IconData icon;

  /// The image provider.
  final ImageProvider? imageProvider;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double? radius;

  static const IconData _defaultIcon = Icons.person;

  /// {@macro flutter_widgetz.CustomAvatar}
  ///
  /// Uses an [AssetImage].
  CustomAvatar.asset(
    String name, {
    super.key,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = AssetImage(name);

  /// {@macro flutter_widgetz.CustomAvatar}
  ///
  /// Uses a [NetworkImage].
  CustomAvatar.network(
    String src, {
    super.key,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = NetworkImage(src);

  bool get hasImage => imageProvider != null;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: hasImage ? null : Colors.transparent,
      foregroundImage: imageProvider,
      onForegroundImageError: hasImage ? (_, __) {} : null,
      radius: radius,
      child: _getChild(),
    );
  }

  Widget _getChild() {
    if (hasImage) {
      return const SizedBox();
    } else {
      return Center(
        child: Icon(icon),
      );
    }
  }
}
