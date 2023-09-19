part of flutter_widgetz;

/// {@template flutter_widgetz.CustomImage}
/// A custom image that handles errors for you.
/// {@endtemplate}
class CustomImage extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomImage}
  const CustomImage({
    super.key,
    required this.imageProvider,
    this.alignment = _defaultAlignment,
    this.color,
    this.fit = _defaultBoxFit,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  });

  /// How to align the image within its bounds.
  final Alignment alignment;

  /// The color to fill in the background of the box.
  final Color? color;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  /// The image to be painted into the decoration.
  final ImageProvider<Object> imageProvider;

  /// This value is multiplied with the opacity of
  /// each image pixel before painting onto the canvas.
  final double opacity;

  /// Defines image pixels to be shown per logical pixels.
  final double scale;

  static const Alignment _defaultAlignment = Alignment.center;
  static const BoxFit _defaultBoxFit = BoxFit.cover;
  static const Widget _defaultErrorWidget = SizedBox();
  static const double _defaultOpacity = 1.0;
  static const double _defaultScale = 1.0;
  static void _defaultImageErrorHandler(Object o, StackTrace? s) {}

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses an [AssetImage].
  CustomImage.asset(
    String? name, {
    super.key,
    this.alignment = _defaultAlignment,
    this.color,
    Widget errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageFrameBuilder? frameBuilder,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
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
    this.alignment = _defaultAlignment,
    this.color,
    Widget errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageFrameBuilder? frameBuilder,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  }) : imageProvider = Image.memory(
          bytes ?? Uint8List(0),
          errorBuilder: (_, __, ___) => errorWidget,
          frameBuilder: frameBuilder,
        ).image;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses a [NetworkImage].
  CustomImage.network(
    String? source, {
    super.key,
    this.alignment = _defaultAlignment,
    this.color,
    Widget errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageLoadingBuilder? loadingBuilder,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  }) : imageProvider = Image.network(
          source ?? '',
          errorBuilder: (_, __, ___) => errorWidget,
          loadingBuilder: loadingBuilder,
        ).image;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    try {
      return Container(
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.secondary,
          image: DecorationImage(
            alignment: alignment,
            fit: fit,
            image: imageProvider,
            onError: _defaultImageErrorHandler,
            opacity: opacity,
            scale: scale,
          ),
        ),
      );
    } catch (_) {
      return Container(
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.secondary,
        ),
      );
    }
  }
}
