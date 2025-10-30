part of flutter_widgetz;

/// {@template flutter_widgetz.Shimmer}
/// A shimmer effect widget.
///
/// Inspired by:
/// https://github.com/hnvn/flutter_shimmer/blob/master/lib/shimmer.dart
///
///![Shimmer](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/shimmer.png)
/// {@endtemplate}
class Shimmer extends StatefulWidget {
  /// {@macro flutter_widgetz.Shimmer}
  Shimmer({
    super.key,
    required this.child,
    Color backgroundColor = _defaultBackgroundColor,
    Gradient? gradient,
    this.period = _defaultPeriod,
  }) : gradient = gradient ?? _getDefaultGradient(backgroundColor);

  /// The child widget shown during shimmer.
  final Widget child;

  /// The gradient used during shimmer.
  final Gradient gradient;

  /// The duration of the shimmer.
  final Duration period;

  static const Color _defaultBackgroundColor = Color(0xFFE0E0E0);
  static const double _defaultBorderRadius = 0;
  static const Color _defaultHighlightColor = Color(0xFFF5F5F5);
  static const Duration _defaultPeriod = Duration(milliseconds: 1500);
  static const List<double> _defaultStops = <double>[
    0.0,
    0.35,
    0.5,
    0.65,
    1.0,
  ];

  static Gradient _getDefaultGradient(Color baseColor) {
    return LinearGradient(
      begin: Alignment.topLeft,
      colors: <Color>[
        baseColor,
        baseColor,
        _defaultHighlightColor,
        baseColor,
        baseColor,
      ],
      stops: _defaultStops,
    );
  }

  /// {@macro flutter_widgetz.Shimmer}
  ///
  /// Banner uses a [Container] as a [child].
  Shimmer.banner({
    super.key,
    Color backgroundColor = _defaultBackgroundColor,
    double borderRadius = _defaultBorderRadius,
    Gradient? gradient,
    double height = 200.0,
    this.period = _defaultPeriod,
  })  : gradient = gradient ?? _getDefaultGradient(backgroundColor),
        child = _Container(
          borderRadius: borderRadius,
          color: backgroundColor,
          height: height,
        );

  /// {@macro flutter_widgetz.Shimmer}
  ///
  /// List tile uses a [ListTile] as a [child].
  Shimmer.listTile({
    super.key,
    Color backgroundColor = _defaultBackgroundColor,
    double borderRadius = _defaultBorderRadius,
    Gradient? gradient,
    this.period = _defaultPeriod,
  })  : gradient = gradient ?? _getDefaultGradient(backgroundColor),
        child = ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: backgroundColor,
          ),
          title: _Container(
            borderRadius: borderRadius,
            color: backgroundColor,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _Container(
                borderRadius: borderRadius,
                color: backgroundColor,
                width: 50.0,
              ),
            ],
          ),
        );

  /// {@macro flutter_widgetz.Shimmer}
  ///
  /// Title uses a [Column] as a [child].
  Shimmer.title({
    super.key,
    Color backgroundColor = _defaultBackgroundColor,
    double borderRadius = _defaultBorderRadius,
    Gradient? gradient,
    this.period = _defaultPeriod,
  })  : gradient = gradient ?? _getDefaultGradient(backgroundColor),
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _Container(
              borderRadius: borderRadius,
              color: backgroundColor,
            ),
            const SizedBox(height: 8.0),
            _Container(
              borderRadius: borderRadius,
              color: backgroundColor,
            ),
          ],
        );

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

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
    return Semantics(
      identifier: 'shimmer',
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (_, Widget? child) {
          return _Shimmer(
            gradient: widget.gradient,
            percent: _controller.value,
            child: child,
          );
        },
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    this.borderRadius = 0,
    this.color,
    this.height = 12.0,
    this.width = double.infinity,
  });

  final double borderRadius;
  final Color? color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      height: height,
      width: width,
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
