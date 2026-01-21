part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAvatar}
/// Uses [CircleAvatar] while dumping image errors.
///
/// Images are show via `foregroundImage`.
///
///![CustomAvatar](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/avatar.png)
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
  final Widget icon;

  /// The image provider.
  final ImageProvider? imageProvider;

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double? radius;

  static const Widget _defaultIcon = Icon(Icons.person);
  static void _defaultImageErrorBuilder(Object o, StackTrace? s) {}

  /// Asset uses [Image.asset].
  ///
  /// {@macro flutter_widgetz.CustomAvatar}
  CustomAvatar.asset(
    String? name, {
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = CustomImage.asset(name).imageProvider;

  /// Memory uses [Image.memory].
  ///
  /// {@macro flutter_widgetz.CustomAvatar}
  CustomAvatar.memory(
    Uint8List? bytes, {
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = CustomImage.memory(bytes).imageProvider;

  /// Network uses [Image.network].
  ///
  /// {@macro flutter_widgetz.CustomAvatar}
  CustomAvatar.network(
    String? source, {
    super.key,
    this.color,
    this.icon = _defaultIcon,
    this.radius,
  }) : imageProvider = CustomImage.network(source).imageProvider;

  bool get _hasImage => imageProvider != null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: 'avatar',
      child: CircleAvatar(
        backgroundColor: _hasImage ? null : color,
        foregroundImage: _hasImage ? imageProvider : null,
        onForegroundImageError: _hasImage ? _defaultImageErrorBuilder : null,
        radius: radius,
        child: FittedBox(
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
