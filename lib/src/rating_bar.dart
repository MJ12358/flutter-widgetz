part of flutter_widgetz;

/// {@template flutter_widgetz.RatingBar}
/// A custom rating bar.
///
///![RatingBar](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/rating_bar.png)
/// {@endtemplate}
class RatingBar extends StatefulWidget {
  /// {@macro flutter_widgetz.RatingBar}
  const RatingBar({
    super.key,
    this.color,
    this.max = 5,
    this.onChanged,
    this.size = 40.0,
    this.unratedColor,
    num? value,
  })  : value = value ?? _defaultValue,
        _readOnly = false;

  /// The color of the stars.
  final Color? color;

  /// Sets the maximum rating.
  final int max;

  /// Called when the current rating is updated.
  final ValueChanged<num>? onChanged;

  /// The size of each star.
  final double size;

  /// The color of an unrated star.
  final Color? unratedColor;

  /// Defines the rating to be set to the rating bar.
  final num value;

  final bool _readOnly;

  static const int _defaultMax = 5;
  static const double _defaultSize = 40.0;
  static const num _defaultValue = 0;

  /// {@macro flutter_widgetz.RatingBar}
  ///
  /// Static is not tappable aka. read only.
  const RatingBar.static({
    super.key,
    this.color,
    this.max = _defaultMax,
    this.size = _defaultSize,
    this.unratedColor,
    num? value,
  })  : onChanged = null,
        value = value ?? _defaultValue,
        _readOnly = true;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late num _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = widget.color ?? theme.colorScheme.primary;
    final Color unratedColor = widget.unratedColor ?? theme.disabledColor;

    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Wrap(
        children: List<Widget>.generate(
          widget.max,
          (int index) => _buildRating(index, color, unratedColor),
        ),
      ),
    );
  }

  Widget _buildRating(int index, Color color, Color unratedColor) {
    final Widget child;

    if (index >= _value) {
      child = _Star(
        color: unratedColor,
        size: widget.size,
      );
    } else if (index >= _value - 0.5) {
      child = _HalfStar(
        color: color,
        unratedColor: unratedColor,
        size: widget.size,
      );
    } else {
      child = _Star(
        color: color,
        size: widget.size,
      );
    }

    final num _result = index + 1;

    if (widget._readOnly) {
      return child;
    }

    return InkWell(
      onTap: () {
        setState(() {
          _value = _result;
        });
        widget.onChanged?.call(_result);
      },
      child: child,
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _StarClipper(),
      child: Container(
        height: size,
        width: size,
        color: color,
      ),
    );
  }
}

class _HalfStar extends StatelessWidget {
  const _HalfStar({
    required this.color,
    required this.size,
    required this.unratedColor,
  });

  final Color color;
  final double size;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRect(
          clipper: _HalfClipper(),
          child: _Star(
            color: color,
            size: size,
          ),
        ),
        ClipRect(
          clipper: _HalfClipper(rtl: true),
          child: _Star(
            color: unratedColor,
            size: size,
          ),
        ),
      ],
    );
  }
}

/// https://stackoverflow.com/questions/63700728/flutter-how-to-draw-a-star
class _StarClipper extends CustomClipper<Path> {
  final int points = 5;

  @override
  Path getClip(Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final Path path = Path();

    final double radius = size.width / 2;
    final double inner = radius / 2;
    final double step = math.pi / points;

    double rotation = math.pi / 2 * 3;

    path.lineTo(centerX, centerY - radius);

    for (int i = 0; i < points; i++) {
      double x = centerX + math.cos(rotation) * radius;
      double y = centerY + math.sin(rotation) * radius;
      path.lineTo(x, y);
      rotation += step;

      x = centerX + math.cos(rotation) * inner;
      y = centerY + math.sin(rotation) * inner;
      path.lineTo(x, y);
      rotation += step;
    }

    path.lineTo(centerX, centerY - radius);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _HalfClipper extends CustomClipper<Rect> {
  _HalfClipper({
    this.rtl = false,
  });

  final bool rtl;

  @override
  Rect getClip(Size size) {
    if (rtl) {
      return Rect.fromLTRB(
        size.width / 2,
        0,
        size.width,
        size.height,
      );
    }

    return Rect.fromLTRB(
      0,
      0,
      size.width / 2,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
