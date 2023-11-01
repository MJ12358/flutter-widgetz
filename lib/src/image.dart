part of flutter_widgetz;

/// {@template flutter_widgetz.CustomImage}
/// A custom image that handles errors for you.
/// {@endtemplate}
class CustomImage extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomImage}
  const CustomImage({
    super.key,
    required this.imageProvider,
    this.alignment = _defaultAlignment,
    this.color,
    this.errorWidget,
    this.fit = _defaultBoxFit,
    this.opacity = _defaultOpacity,
    this.scale = _defaultScale,
  });

  /// How to align the image within its bounds.
  final Alignment alignment;

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
  static const Widget _defaultErrorWidget = SizedBox();
  static const double _defaultOpacity = 1.0;
  static const double _defaultScale = 1.0;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses an [AssetImage].
  CustomImage.asset(
    String? name, {
    super.key,
    this.alignment = _defaultAlignment,
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
        ).image;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses a [MemoryImage].
  CustomImage.memory(
    Uint8List? bytes, {
    super.key,
    this.alignment = _defaultAlignment,
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
        ).image;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// Uses a [NetworkImage].
  CustomImage.network(
    String? source, {
    super.key,
    this.alignment = _defaultAlignment,
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
        ).image;

  /// {@macro flutter_widgetz.CustomImage}
  ///
  /// This factory attempts to determine the input
  /// type to construct the proper image for you.
  factory CustomImage.dynamic(
    Object? object, {
    Alignment alignment = _defaultAlignment,
    Color? color,
    Widget errorWidget = _defaultErrorWidget,
    BoxFit fit = _defaultBoxFit,
    double opacity = _defaultOpacity,
    double scale = _defaultScale,
  }) {
    try {
      if (object is Uint8List || object == null) {
        return CustomImage.memory(
          object as Uint8List?,
          alignment: alignment,
          color: color,
          errorWidget: errorWidget,
          fit: fit,
          opacity: opacity,
          scale: scale,
        );
      }

      if (object is String) {
        final bool isUri = Uri.tryParse(object)?.isAbsolute ?? false;

        if (isUri) {
          return CustomImage.network(
            object,
            alignment: alignment,
            color: color,
            errorWidget: errorWidget,
            fit: fit,
            opacity: opacity,
            scale: scale,
          );
        }

        final bool isBase64 = RegExp(
          r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$',
        ).hasMatch(object);

        if (isBase64) {
          return CustomImage.memory(
            base64Decode(object),
            alignment: alignment,
            color: color,
            errorWidget: errorWidget,
            fit: fit,
            opacity: opacity,
            scale: scale,
          );
        }

        return CustomImage.asset(
          object,
          alignment: alignment,
          color: color,
          errorWidget: errorWidget,
          fit: fit,
          opacity: opacity,
          scale: scale,
        );
      }
    } catch (_) {
      // fall through ↓
    }

    return CustomImage(
      imageProvider: Image.memory(_kTransparentImage).image,
      alignment: alignment,
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

  @override
  void initState() {
    super.initState();
    _hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    try {
      return Container(
        decoration: BoxDecoration(
          color: widget.color ?? theme.colorScheme.secondary,
          image: DecorationImage(
            alignment: widget.alignment,
            fit: widget.fit,
            image: widget.imageProvider,
            onError: (_, __) {
              setState(() {
                _hasError = true;
              });
            },
            opacity: widget.opacity,
            scale: widget.scale,
          ),
        ),
        // for some reason, the errorBuilder is not being called
        child: _hasError ? widget.errorWidget : null,
      );
    } catch (_) {
      return Container(
        decoration: BoxDecoration(
          color: widget.color ?? theme.colorScheme.secondary,
        ),
        child: widget.errorWidget,
      );
    }
  }
}
