part of flutter_widgetz;

/// {@template flutter_widgetz.CustomImage}
/// A custom image that handles errors for you.
///
///![CustomImage](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/image.png)
/// {@endtemplate}
class CustomImage extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomImage}
  const CustomImage({
    super.key,
    required this.imageProvider,
    this.alignment = _defaultAlignment,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.errorWidget,
    this.fit = _defaultBoxFit,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  });

  /// How to align the image within its bounds.
  final Alignment alignment;

  /// The height of the image in pixels to cache.
  final int? cacheHeight;

  /// The width of the image in pixels to cache.
  final int? cacheWidth;

  /// The color to fill in the background of the box.
  final Color? color;

  /// A replacement widget when a error occurs.
  final Widget? errorWidget;

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
  static const Widget _defaultErrorWidget = SizedBox.shrink();
  static const double _defaultOpacity = 1.0;
  static const double _defaultScale = 1.0;

  /// Uses an [AssetImage].
  ///
  /// {@macro flutter_widgetz.CustomImage}
  CustomImage.asset(
    String? name, {
    super.key,
    this.alignment = _defaultAlignment,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageFrameBuilder? frameBuilder,
    this.opacity = _defaultOpacity,
    String? package,
    this.scale = _defaultScale,
  }) : imageProvider = Image.asset(
          name ?? '',
          errorBuilder: (_, __, ___) => errorWidget!,
          frameBuilder: frameBuilder,
          package: package,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
        ).image;

  /// Uses a [MemoryImage].
  ///
  /// {@macro flutter_widgetz.CustomImage}
  CustomImage.memory(
    Uint8List? bytes, {
    super.key,
    this.alignment = _defaultAlignment,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageFrameBuilder? frameBuilder,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  }) : imageProvider = Image.memory(
          bytes ?? Uint8List(0),
          errorBuilder: (_, __, ___) => errorWidget!,
          frameBuilder: frameBuilder,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
        ).image;

  /// Uses a [NetworkImage].
  ///
  /// {@macro flutter_widgetz.CustomImage}
  CustomImage.network(
    String? source, {
    super.key,
    this.alignment = _defaultAlignment,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.errorWidget = _defaultErrorWidget,
    this.fit = _defaultBoxFit,
    ImageLoadingBuilder? loadingBuilder,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  }) : imageProvider = Image.network(
          source ?? '',
          errorBuilder: (_, __, ___) => errorWidget!,
          loadingBuilder: loadingBuilder,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
        ).image;

  /// This factory attempts to determine the input
  /// type to construct the proper image for you.
  ///
  /// {@macro flutter_widgetz.CustomImage}
  factory CustomImage.dynamic(
    Object? input, {
    Alignment alignment = _defaultAlignment,
    int? cacheHeight,
    int? cacheWidth,
    Color? color,
    Widget errorWidget = _defaultErrorWidget,
    BoxFit fit = _defaultBoxFit,
    double opacity = _defaultOpacity,
    double scale = _defaultScale,
  }) {
    try {
      if (input is Uint8List || input == null) {
        return CustomImage.memory(
          input as Uint8List?,
          alignment: alignment,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          color: color,
          errorWidget: errorWidget,
          fit: fit,
          opacity: opacity,
          scale: scale,
        );
      }

      if (input is String) {
        if (input.isUri) {
          return CustomImage.network(
            input,
            alignment: alignment,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth,
            color: color,
            errorWidget: errorWidget,
            fit: fit,
            opacity: opacity,
            scale: scale,
          );
        }

        if (input.isBase64) {
          return CustomImage.memory(
            base64Decode(input),
            alignment: alignment,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth,
            color: color,
            errorWidget: errorWidget,
            fit: fit,
            opacity: opacity,
            scale: scale,
          );
        }

        return CustomImage.asset(
          input,
          alignment: alignment,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          color: color,
          errorWidget: errorWidget,
          fit: fit,
          opacity: opacity,
          scale: scale,
        );
      }
    } catch (_) {
      // when none of the other conditions match,
      // fall through ↓
    }

    return CustomImage(
      imageProvider: Image.memory(_kTransparentImage).image,
      alignment: alignment,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      color: color,
      fit: fit,
      opacity: opacity,
      scale: scale,
    );
  }

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late bool _hasError;
  late ImageProvider _imageProvider;

  @override
  void initState() {
    super.initState();
    _hasError = false;
    _imageProvider = widget.imageProvider;
  }

  @override
  void didUpdateWidget(CustomImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _hasError = false;
    _imageProvider = widget.imageProvider;
  }

  void _onError(Object o, StackTrace? st) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _hasError = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = widget.color ?? theme.colorScheme.secondary;

    try {
      return Container(
        decoration: BoxDecoration(
          color: color,
          image: DecorationImage(
            alignment: widget.alignment,
            fit: widget.fit,
            image: _imageProvider,
            onError: _onError,
            opacity: widget.opacity,
            scale: widget.scale,
          ),
        ),
        // for some reason, the imageProvider.errorBuilder is not being called
        child: _hasError ? widget.errorWidget : null,
      );
    } catch (_) {
      return Container(
        decoration: BoxDecoration(
          color: color,
        ),
        child: widget.errorWidget,
      );
    }
  }
}
