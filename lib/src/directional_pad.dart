part of flutter_widgetz;

/// {@template flutter_widgetz.DirectionalPad}
/// A directional pad widget.
///
///![DirectionalPad](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/directional_pad.png)
/// {@endtemplate}
class DirectionalPad extends StatelessWidget {
  /// {@macro flutter_widgetz.DirectionalPad}
  DirectionalPad({
    super.key,
    required this.buttons,
    this.backgroundColor,
    this.borderColor,
    double? borderSize,
    this.buttonColor,
    this.onTap,
    this.padding = _defaultPadding,
    this.shape = _defaultShape,
    this.size = _defaultSize,
  })  : borderSize = borderSize ?? _getDefaultBorderSize(size),
        assert(buttons.length == 4, 'Button length must be four.');

  /// The list of buttons in a clockwise direction.
  final List<Widget> buttons;

  /// A callback called when widget is tapped.
  final ValueChanged<AxisDirection>? onTap;

  /// The color to paint behind the [buttons].
  final Color? backgroundColor;

  /// The color of the border.
  ///
  /// Defaults to an alpha of the [backgroundColor].
  final Color? borderColor;

  /// The size of the border.
  final double borderSize;

  /// The color of the [buttons].
  final Color? buttonColor;

  /// The amount of space by which to inset the child.
  final EdgeInsets padding;

  /// The shape to fill the background.
  final BoxShape shape;

  /// The size of this widget.
  final double size;

  static const EdgeInsets _defaultPadding = EdgeInsets.zero;
  static const BoxShape _defaultShape = BoxShape.circle;
  static const double _defaultSize = 90.0;
  static double _getDefaultBorderSize(double size) {
    return size * 0.1;
  }

  /// {@macro flutter_widgetz.DirectionalPad}
  ///
  /// Arrow uses material `Icons.arrow`.
  DirectionalPad.arrow({
    super.key,
    this.backgroundColor,
    this.borderColor,
    double? borderSize,
    this.buttonColor,
    this.onTap,
    this.padding = _defaultPadding,
    this.shape = _defaultShape,
    this.size = _defaultSize,
  })  : borderSize = borderSize ?? _getDefaultBorderSize(size),
        buttons = const <Icon>[
          Icon(Icons.arrow_upward),
          Icon(Icons.arrow_forward),
          Icon(Icons.arrow_downward),
          Icon(Icons.arrow_back),
        ];

  /// {@macro flutter_widgetz.DirectionalPad}
  ///
  /// Chevron uses material `Icons.chevron`.
  DirectionalPad.chevron({
    super.key,
    this.backgroundColor,
    this.borderColor,
    double? borderSize,
    this.buttonColor,
    this.onTap,
    this.padding = _defaultPadding,
    this.shape = _defaultShape,
    this.size = _defaultSize,
  })  : borderSize = borderSize ?? _getDefaultBorderSize(size),
        buttons = const <Widget>[
          RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.chevron_left),
          ),
          Icon(Icons.chevron_right),
          RotatedBox(
            quarterTurns: 3,
            child: Icon(Icons.chevron_left),
          ),
          Icon(Icons.chevron_left),
        ];

  /// {@macro flutter_widgetz.DirectionalPad}
  ///
  /// Attempts to emulate a classic d-pad.
  DirectionalPad.classic({
    super.key,
    this.buttonColor,
    this.onTap,
    this.padding = _defaultPadding,
    this.size = _defaultSize,
  })  : backgroundColor = Colors.transparent,
        borderColor = Colors.transparent,
        borderSize = 0.0,
        shape = BoxShape.rectangle,
        buttons = <Widget>[
          _PadButton(
            color: buttonColor,
            path: _kPadUpIcon,
            size: size,
          ),
          _PadButton(
            color: buttonColor,
            path: _kPadRightIcon,
            size: size,
          ),
          _PadButton(
            color: buttonColor,
            path: _kPadDownIcon,
            size: size,
          ),
          _PadButton(
            color: buttonColor,
            path: _kPadLeftIcon,
            size: size,
          ),
        ];

  /// {@macro flutter_widgetz.DirectionalPad}
  ///
  /// Attempts to emulate the look of an PlayStation controller.
  DirectionalPad.playstation({
    super.key,
    this.onTap,
    this.padding = _defaultPadding,
    this.size = _defaultSize,
  })  : backgroundColor = Colors.transparent,
        borderColor = Colors.transparent,
        borderSize = 0.0,
        buttonColor = null,
        shape = BoxShape.circle,
        buttons = <Widget>[
          _PlayStationButton.triangle(size: size),
          _PlayStationButton.circle(size: size),
          _PlayStationButton.cross(size: size),
          _PlayStationButton.square(size: size),
        ];

  /// {@macro flutter_widgetz.DirectionalPad}
  ///
  /// Attempts to emulate the look of an Xbox controller.
  DirectionalPad.xbox({
    super.key,
    this.onTap,
    this.padding = _defaultPadding,
    this.size = _defaultSize,
  })  : backgroundColor = Colors.transparent,
        borderColor = Colors.transparent,
        borderSize = 0.0,
        buttonColor = null,
        shape = BoxShape.circle,
        buttons = <Widget>[
          _XboxButton.y(size: size),
          _XboxButton.b(size: size),
          _XboxButton.a(size: size),
          _XboxButton.x(size: size),
        ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color _backgroundColor = backgroundColor ?? theme.colorScheme.primary;
    final Color _borderColor = borderColor ?? _backgroundColor.withAlpha(80);
    final Color _buttonColor = buttonColor ?? _backgroundColor.blackOrWhite;

    return IconTheme(
      data: theme.iconTheme.copyWith(color: _buttonColor),
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            color: _borderColor,
            shape: shape,
          ),
          child: Padding(
            padding: EdgeInsets.all(borderSize),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: _backgroundColor,
                shape: shape,
              ),
              child: _Buttons(
                buttons: buttons,
                onTap: onTap,
                shape: shape,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.buttons,
    required this.shape,
    this.onTap,
  });

  final List<Widget> buttons;
  final BoxShape shape;
  final ValueChanged<AxisDirection>? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _Button(
          onTap: () => onTap?.call(AxisDirection.up),
          shape: shape,
          child: buttons[0],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _Button(
              onTap: () => onTap?.call(AxisDirection.left),
              shape: shape,
              child: buttons[3],
            ),
            _Button(
              onTap: () => onTap?.call(AxisDirection.right),
              shape: shape,
              child: buttons[1],
            ),
          ],
        ),
        _Button(
          onTap: () => onTap?.call(AxisDirection.down),
          shape: shape,
          child: buttons[2],
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.child,
    required this.onTap,
    required this.shape,
  });

  final Widget child;
  final VoidCallback onTap;
  final BoxShape shape;

  ShapeBorder get _border {
    switch (shape) {
      case BoxShape.circle:
        return const CircleBorder();
      case BoxShape.rectangle:
        return const RoundedRectangleBorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: _border,
      onTap: onTap,
      child: child,
    );
  }
}

//
// Custom button iterations
//

class _PadButton extends StatelessWidget {
  const _PadButton({
    required this.path,
    required this.size,
    this.color,
  });

  final String path;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final double cSize = size / 3.0;
    return SizedBox(
      height: cSize,
      width: cSize,
      child: FittedBox(
        child: Image.asset(
          path,
          color: color,
          package: _kPackage,
        ),
      ),
    );
  }
}

class _PlayStationButton extends StatelessWidget {
  const _PlayStationButton({
    required this.color,
    required this.padding,
    required this.path,
    required this.size,
    required this.identifier,
  });

  final Color color;
  final double padding;
  final String path;
  final double size;
  final String identifier;

  const _PlayStationButton.triangle({
    required this.size,
  })  : color = const Color(0xFF3f8b86),
        padding = 38.0,
        path = _kTriangleIcon,
        identifier = 'triangle';

  const _PlayStationButton.circle({
    required this.size,
  })  : color = const Color(0xFFbc3f32),
        padding = 28.0,
        path = _kCircleIcon,
        identifier = 'circle';

  const _PlayStationButton.cross({
    required this.size,
  })  : color = const Color(0xFF6773a8),
        padding = 48.0,
        path = _kCrossIcon,
        identifier = 'cross';

  const _PlayStationButton.square({
    required this.size,
  })  : color = const Color(0xFFc06c9a),
        padding = 56.0,
        path = _kSquareIcon,
        identifier = 'square';

  @override
  Widget build(BuildContext context) {
    final double cSize = size / 3.0;
    return Semantics(
      identifier: identifier,
      child: Container(
        height: cSize,
        width: cSize,
        decoration: const BoxDecoration(
          color: Color(0xFF28282a),
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Image.asset(
              path,
              color: color,
              package: _kPackage,
            ),
          ),
        ),
      ),
    );
  }
}

class _XboxButton extends StatelessWidget {
  const _XboxButton({
    required this.color,
    required this.path,
    required this.size,
    required this.identifier,
  });

  final Color color;
  final String path;
  final double size;
  final String identifier;

  const _XboxButton.y({
    required this.size,
  })  : color = const Color(0xFFceb133),
        path = _kYIcon,
        identifier = 'y';

  const _XboxButton.b({
    required this.size,
  })  : color = const Color(0xFFd23727),
        path = _kBIcon,
        identifier = 'b';

  const _XboxButton.a({
    required this.size,
  })  : color = const Color(0xFF397957),
        path = _kAIcon,
        identifier = 'a';

  const _XboxButton.x({
    required this.size,
  })  : color = const Color(0xFF344e9f),
        path = _kXIcon,
        identifier = 'x';

  @override
  Widget build(BuildContext context) {
    final double cSize = size / 3.0;
    return Semantics(
      identifier: identifier,
      child: Container(
        height: cSize,
        width: cSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Padding(
            padding: const EdgeInsets.all(58.0),
            child: Image.asset(
              path,
              color: Colors.white,
              package: _kPackage,
            ),
          ),
        ),
      ),
    );
  }
}
