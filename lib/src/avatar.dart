part of flutter_widgetz;

/// Uses `CircleAvatar` while dumping image errors.
///
/// Images are show via `foregroundImage`.
class CustomAvatar extends StatelessWidget {
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
      onForegroundImageError: (_, __) {},
      radius: radius,
      child: hasImage
          ? const SizedBox()
          : const Center(
              child: Icon(Icons.person),
            ),
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
}
