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
    this.networkImage,
    this.radius,
  }) : super(key: key);

  final String? assetImage;
  final String? networkImage;
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
    return hasImage
        ? const SizedBox()
        : const Center(
            child: Icon(Icons.person),
          );
  }
}
