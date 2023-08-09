part of flutter_widgetz;

// TODO: this is a WIP, but the essence is there.

/// {@template flutter_widgetz.Shimmer}
/// A shimmer effect widget.
///
/// Inspired by:
/// https://github.com/hnvn/flutter_shimmer/blob/master/lib/shimmer.dart
/// {@endtemplate}
class Shimmer extends StatefulWidget {
  /// {@macro flutter_widgetz.Shimmer}
  Shimmer({
    super.key,
    required this.child,
    Gradient? gradient,
    this.period = _defaultPeriod,
  }) : gradient = gradient ?? _defaultGradient;

  /// The child widget shown during shimmer.
  final Widget child;

  /// The gradient used during shimmer.
  final Gradient gradient;

  /// The duration of the shimmer.
  final Duration period;

  static final Color _defaultBaseColor = Colors.grey.shade300;
  static final Color _defaultHighlightColor = Colors.grey.shade100;
  static const Duration _defaultPeriod = Duration(milliseconds: 1500);
  static const List<double> _defaultStops = <double>[
    0.0,
    0.35,
    0.5,
    0.65,
    1.0,
  ];
  static final Gradient _defaultGradient = LinearGradient(
    begin: Alignment.topLeft,
    colors: <Color>[
      _defaultBaseColor,
      _defaultBaseColor,
      _defaultHighlightColor,
      _defaultBaseColor,
      _defaultBaseColor,
    ],
    stops: _defaultStops,
  );

  static Widget _getContainer({
    Color? color = Colors.white,
    BoxDecoration? decoration,
    double? height = 12.0,
    EdgeInsets? margin,
    double? width = double.infinity,
  }) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            color: color,
          ),
      height: height,
      margin: margin,
      width: width,
    );
  }

  /// {@macro flutter_widgetz.Shimmer}
  ///
  /// List tile uses a [ListTile] as a [child].
  Shimmer.listTile({
    super.key,
    Gradient? gradient,
    this.period = _defaultPeriod,
  })  : gradient = gradient ?? _defaultGradient,
        child = ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
          ),
          title: _getContainer(
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getContainer(
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              _getContainer(
                width: 50.0,
              ),
            ],
          ),
        );

  /// {@macro flutter_widgetz.Shimmer}
  ///
  /// Banner uses a [Container] with a height of 200 as a [child].
  Shimmer.banner({
    super.key,
    Gradient? gradient,
    this.period = _defaultPeriod,
  })  : gradient = gradient ?? _defaultGradient,
        child = _getContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          height: 200.0,
          margin: const EdgeInsets.all(16.0),
        );

  /// {@macro flutter_widgetz.Shimmer}
  ///
  /// Title uses a [Column] wrapped in [Padding].
  Shimmer.title({
    super.key,
    Gradient? gradient,
    this.period = _defaultPeriod,
  })  : gradient = gradient ?? _defaultGradient,
        child = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getContainer(),
              const SizedBox(height: 8.0),
              _getContainer(),
            ],
          ),
        );

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.period,
    )..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _controller.repeat();
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (_, Widget? child) {
        return _Shimmer(
          gradient: widget.gradient,
          percent: _controller.value,
          child: child,
        );
      },
    );
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final Gradient gradient;

  const _Shimmer({
    super.child,
    required this.percent,
    required this.gradient,
  });

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, gradient);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.setPercent(percent);
    shimmer.setGradient(gradient);
  }
}

class _ShimmerFilter extends RenderProxyBox {
  Gradient _gradient;
  double _percent;

  _ShimmerFilter(this._percent, this._gradient);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  void setPercent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  void setGradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final double width = child!.size.width;
      final double height = child!.size.height;

      Rect rect;
      double dx;
      double dy;

      dx = _offset(-width, width, _percent);
      dy = 0.0;
      rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);

      layer ??= ShaderMaskLayer();

      layer!
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}
