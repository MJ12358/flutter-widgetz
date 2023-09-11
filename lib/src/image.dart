part of flutter_widgetz;

/// {@template flutter_widgetz.CustomImage}
/// A custom image that handles errors for you.
/// {@endtemplate}
class CustomImage extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomImage}
  const CustomImage({
    super.key,
    required this.imageProvider,
    this.color,
    this.fit = _defaultBoxFit,
  });

  /// The color to fill in the background of the box.
  final Color? color;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  /// The image to be painted into the decoration.
  final ImageProvider<Object> imageProvider;

  static const BoxFit _defaultBoxFit = BoxFit.cover;
  static const Widget _defaultErrorWidget = SizedBox();
  static void _defaultImageErrorHandler(Object o, StackTrace? s) {}

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses an [AssetImage].
  CustomImage.asset(
    String? name, {
    super.key,
    this.color,
    Widget errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageFrameBuilder? frameBuilder,
  }) : imageProvider = Image.asset(
          name ?? '',
          errorBuilder: (_, __, ___) => errorWidget,
          frameBuilder: frameBuilder,
        ).image;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses a [MemoryImage].
  CustomImage.memory(
    Uint8List? bytes, {
    super.key,
    this.color,
    Widget errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageFrameBuilder? frameBuilder,
  }) : imageProvider = Image.memory(
          bytes ?? Uint8List(0),
          errorBuilder: (_, __, ___) => errorWidget,
          frameBuilder: frameBuilder,
        ).image;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses a [NetworkImage].
  CustomImage.network(
    String? src, {
    super.key,
    this.color,
    Widget errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageLoadingBuilder? loadingBuilder,
  }) : imageProvider = Image.network(
          src ?? '',
          errorBuilder: (_, __, ___) => errorWidget,
          loadingBuilder: loadingBuilder,
        ).image;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.secondary,
        image: DecorationImage(
          fit: fit,
          image: imageProvider,
          onError: _defaultImageErrorHandler,
        ),
      ),
    );
  }
}
