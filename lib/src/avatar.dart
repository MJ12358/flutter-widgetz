part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAvatar}
/// Uses [CircleAvatar] while dumping image errors.
///
/// Images are show via `foregroundImage`.
/// {@endtemplate}
class CustomAvatar extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomAvatar}
  const CustomAvatar({
    Key? key,
    this.assetImage,
    this.icon = Icons.person,
    this.networkImage,
    this.radius,
  }) : super(key: key);

  /// The foreground asset image of the circle.
  final String? assetImage;

  /// The icon to display when no image is present.
  final IconData icon;

  /// The foreground network image of the circle.
  final String? networkImage;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double? radius;

  bool get hasImage => hasAssetImage || hasNetworkImage;
  bool get hasAssetImage => assetImage != null;
  bool get hasNetworkImage => networkImage != null;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: hasImage ? null : Colors.transparent,
      foregroundImage: _getImage(),
      onForegroundImageError: hasImage ? (_, __) {} : null,
      radius: radius,
      child: _getChild(),
    );
  }

  ImageProvider? _getImage() {
    if (hasAssetImage) {
      return AssetImage(assetImage!);
    } else if (hasNetworkImage) {
      return NetworkImage(networkImage!);
    } else {
      return null;
    }
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
