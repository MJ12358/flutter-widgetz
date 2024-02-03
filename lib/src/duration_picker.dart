part of flutter_widgetz;

const double _kDurationPickerWidthPortrait = 328.0;
const double _kDurationPickerHeightPortrait = 380.0;
const double _kTwoPi = 2 * math.pi;
const double _kPiByTwo = math.pi / 2;

/// {@template flutter_widgetz.DurationPicker}
/// A widget for picking durations.
/// Inspired by the Material Design time picker widget.
///
/// Modified from:
/// https://github.com/juliansteenbakker/duration_picker
/// {@endtemplate}
class DurationPicker extends StatefulWidget {
  /// {@macro flutter_widgetz.DurationPicker}
  const DurationPicker({
    super.key,
    required this.onChanged,
    this.color,
    Duration? value,
    this.height,
    int? snapToMins,
    DurationPickerUnit? unit,
    this.width,
  })  : value = value ?? Duration.zero,
        snapToMins = snapToMins ?? 1,
        unit = unit ?? DurationPickerUnit.minute;

  /// Called whenever the value changes.
  final ValueChanged<Duration> onChanged;

  /// The color of the picker.
  final Color? color;

  /// The height of the picker.
  final double? height;

  /// The resolution of mins of the dial,
  /// i.e. if snapToMins = 5,
  /// only durations of 5min intervals will be selectable.
  final int snapToMins;

  /// The unit for this picker.
  final DurationPickerUnit unit;

  /// The actual duration.
  final Duration value;

  /// The width of the picker.
  final double? width;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late Duration _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(DurationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? _kDurationPickerWidthPortrait / 1.5,
      height: widget.height ?? _kDurationPickerHeightPortrait / 1.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _Dial(
              color: widget.color,
              value: _value,
              onChanged: _onChanged,
              unit: widget.unit,
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(Duration duration) {
    final int round =
        (duration.inMinutes / widget.snapToMins).round() * widget.snapToMins;

    final Duration value = Duration(minutes: round);

    widget.onChanged(value);
    setState(() {
      _value = value;
    });
  }
}

class _Dial extends StatefulWidget {
  const _Dial({
    required this.value,
    required this.onChanged,
    this.color,
    this.unit = DurationPickerUnit.minute,
  });

  final Duration value;
  final ValueChanged<Duration> onChanged;
  final Color? color;
  final DurationPickerUnit unit;

  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<_Dial> with SingleTickerProviderStateMixin {
  late Tween<double> _thetaTween;
  late Animation<double> _theta;
  late AnimationController _thetaController;
  final double _pct = 0.0;
  int _secondaryUnitValue = 0;
  int _unitValue = 0;
  double _turningAngle = 0.0;
  Offset? _position;
  Offset? _center;

  @override
  void initState() {
    super.initState();

    _thetaController = AnimationController(
      duration: kThemeChangeDuration,
      vsync: this,
    );

    _thetaTween = Tween<double>(
      begin: _getThetaForDuration(widget.value, widget.unit),
    );

    _theta = _thetaTween.animate(
      CurvedAnimation(parent: _thetaController, curve: Curves.fastOutSlowIn),
    )..addListener(() => setState(() {}));

    _thetaController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _secondaryUnitValue = _secondaryUnitHand();
        _unitValue = _unitHand();
        setState(() {});
      }
    });

    _turningAngle = _kPiByTwo - _turningAngleFactor() * _kTwoPi;
    _secondaryUnitValue = _secondaryUnitHand();
    _unitValue = _unitHand();
  }

  @override
  void dispose() {
    _thetaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Color? backgroundColor;

    switch (theme.brightness) {
      case Brightness.light:
        backgroundColor = Colors.grey[200];
      case Brightness.dark:
        backgroundColor = theme.colorScheme.background;
    }

    int? selectedDialValue;
    _secondaryUnitValue = _secondaryUnitHand();
    _unitValue = _unitHand();

    return GestureDetector(
      excludeFromSemantics: true,
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      onTapUp: _handleTapUp,
      child: CustomPaint(
        painter: _DialPainter(
          pct: _pct,
          unitMultiplier: _secondaryUnitValue,
          unitHand: _unitValue,
          unit: widget.unit,
          context: context,
          selectedValue: selectedDialValue,
          labels: _buildUnitLabels(theme.textTheme),
          backgroundColor: backgroundColor,
          accentColor: widget.color ?? theme.colorScheme.secondary,
          theta: _theta.value,
          textDirection: Directionality.of(context),
        ),
      ),
    );
  }

  static double _nearest(double target, double a, double b) {
    return ((target - a).abs() < (target - b).abs()) ? a : b;
  }

  void _animateTo(double targetTheta) {
    final double currentTheta = _theta.value;
    double beginTheta =
        _nearest(targetTheta, currentTheta, currentTheta + _kTwoPi);
    beginTheta = _nearest(targetTheta, beginTheta, currentTheta - _kTwoPi);
    _thetaTween
      ..begin = beginTheta
      ..end = targetTheta;
    _thetaController
      ..value = 0.0
      ..forward();
  }

  double _getThetaForDuration(Duration duration, DurationPickerUnit unit) {
    final int units = unit.durationBase(duration);
    final int baseToSecondaryFactor = unit.secondaryFactor;
    return (_kPiByTwo -
            (units % baseToSecondaryFactor) /
                baseToSecondaryFactor.toDouble() *
                _kTwoPi) %
        _kTwoPi;
  }

  double _turningAngleFactor() {
    return widget.unit.durationBase(widget.value) / widget.unit.secondaryFactor;
  }

  Duration _getTimeForTheta(double theta) {
    return _angleToDuration(_turningAngle);
  }

  Duration _notifyOnChangedIfNeeded() {
    _secondaryUnitValue = _secondaryUnitHand();
    _unitValue = _unitHand();
    final Duration d = _angleToDuration(_turningAngle);
    widget.onChanged(d);
    return d;
  }

  void _updateThetaForPan() {
    setState(() {
      final Offset offset = _position! - _center!;
      final double angle =
          (math.atan2(offset.dx, offset.dy) - _kPiByTwo) % _kTwoPi;

      // Stop accidental abrupt pans from making the dial
      // seem like it starts from 1h.
      // (happens when wanting to pan from 0 clockwise,
      // but when doing so quickly, one actually pans from
      // before 0 (e.g. setting the duration to 59mins,
      // and then crossing 0, which would then mean 1h 1min).
      if (angle >= _kPiByTwo &&
          _theta.value <= _kPiByTwo &&
          _theta.value >= 0.1 && // to allow the radians sign change at 15mins.
          _secondaryUnitValue == 0) {
        return;
      }

      _thetaTween
        ..begin = angle
        ..end = angle;
    });
  }

  void _handlePanStart(DragStartDetails details) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    _position = box?.globalToLocal(details.globalPosition);
    _center = box?.size.center(Offset.zero);
    _notifyOnChangedIfNeeded();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    final double oldTheta = _theta.value;
    _position = _position! + details.delta;
    // _position! += details.delta;
    _updateThetaForPan();
    final double newTheta = _theta.value;
    _updateTurningAngle(oldTheta, newTheta);
    _notifyOnChangedIfNeeded();
  }

  int _secondaryUnitHand() {
    return widget.unit.durationSecondary(widget.value);
  }

  int _unitHand() {
    // Result is in [0; num base units in secondary unit - 1],
    // even if overall time is >= 1 secondary unit
    return widget.unit.durationBase(widget.value) % widget.unit.secondaryFactor;
  }

  Duration _angleToDuration(double angle) {
    return widget.unit.toDuration(_angleTounit(angle));
  }

  double _angleTounit(double angle) {
    // Coordinate transformation from mathematical COS to dial COS
    final double dialAngle = _kPiByTwo - angle;

    // Turn dial angle into minutes, may go beyond 60 minutes (multiple turns)
    return dialAngle / _kTwoPi * widget.unit.secondaryFactor;
  }

  void _updateTurningAngle(double oldTheta, double newTheta) {
    // Register any angle by which the user has turned the dial.
    //
    // The resulting turning angle fully captures the state of the dial,
    // including multiple turns (= full hours). The [_turningAngle] is in
    // mathematical coordinate system, i.e. 3-o-clock position being zero, and
    // increasing counter clock wise.

    // From positive to negative (in mathematical COS)
    if (newTheta > 1.5 * math.pi && oldTheta < 0.5 * math.pi) {
      _turningAngle = _turningAngle - ((_kTwoPi - newTheta) + oldTheta);
    }
    // From negative to positive (in mathematical COS)
    else if (newTheta < 0.5 * math.pi && oldTheta > 1.5 * math.pi) {
      _turningAngle = _turningAngle + ((_kTwoPi - oldTheta) + newTheta);
    } else {
      _turningAngle = _turningAngle + (newTheta - oldTheta);
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    _position = null;
    _center = null;
    _animateTo(_getThetaForDuration(widget.value, widget.unit));
  }

  void _handleTapUp(TapUpDetails details) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    _position = box?.globalToLocal(details.globalPosition);
    _center = box?.size.center(Offset.zero);
    _updateThetaForPan();
    _notifyOnChangedIfNeeded();
    _animateTo(
      _getThetaForDuration(_getTimeForTheta(_theta.value), widget.unit),
    );
    _position = null;
    _center = null;
  }

  List<TextPainter> _buildUnitLabels(TextTheme textTheme) {
    final TextStyle? style = textTheme.titleMedium;
    final List<Duration> unitMarkerValues = widget.unit.valueMarkers;
    final List<TextPainter> labels = <TextPainter>[];
    for (final Duration duration in unitMarkerValues) {
      final TextPainter painter = TextPainter(
        text: TextSpan(
          style: style,
          text: widget.unit.durationString(duration),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labels.add(painter);
    }

    return labels;
  }
}

class _DialPainter extends CustomPainter {
  const _DialPainter({
    required this.accentColor,
    required this.backgroundColor,
    required this.context,
    required this.labels,
    required this.pct,
    required this.selectedValue,
    required this.theta,
    required this.textDirection,
    required this.unit,
    required this.unitHand,
    required this.unitMultiplier,
  });

  final Color accentColor;
  final Color? backgroundColor;
  final BuildContext context;
  final List<TextPainter> labels;
  final double pct;
  final int? selectedValue;
  final double theta;
  final TextDirection textDirection;
  final int unitMultiplier;
  final int unitHand;
  final DurationPickerUnit unit;

  @override
  void paint(Canvas canvas, Size size) {
    final ThemeData theme = Theme.of(context);

    const double epsilon = .001;
    const double sweep = _kTwoPi - epsilon;
    const double startAngle = -math.pi / 2.0;

    final double radius = size.shortestSide / 2.0;
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final Offset centerPoint = center;

    final double pctTheta = (0.25 - (theta % _kTwoPi) / _kTwoPi) % 1.0;

    // Draw the background outer ring.
    canvas.drawCircle(centerPoint, radius, Paint()..color = backgroundColor!);

    // Draw a translucent circle for every secondary unit.
    for (int i = 0; i < unitMultiplier; i = i + 1) {
      canvas.drawCircle(
        centerPoint,
        radius,
        Paint()..color = accentColor.withOpacity((i == 0) ? 0.3 : 0.1),
      );
    }

    // Draw the inner background circle.
    canvas.drawCircle(
      centerPoint,
      radius * 0.88,
      Paint()..color = theme.canvasColor,
    );

    // Draw the handle that is used to drag
    // and to indicate the position around the circle.
    final Paint handlePaint = Paint()..color = accentColor;
    final Offset handlePoint = _getOffsetForTheta(center, theta, radius - 10.0);
    canvas.drawCircle(handlePoint, 20.0, handlePaint);

    // Draw the Text in the center of the circle
    // which displays the duration string.
    final String secondaryUnits =
        (unitMultiplier == 0) ? '' : '$unitMultiplier${unit.secondaryString} ';

    final String units = '$unitHand';

    final TextPainter textDurationValuePainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '$secondaryUnits$units',
        style: theme.textTheme.displayMedium!
            .copyWith(fontSize: size.shortestSide * 0.15),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final Offset middleForValueText = Offset(
      centerPoint.dx - (textDurationValuePainter.width / 2),
      centerPoint.dy - textDurationValuePainter.height / 2,
    );

    textDurationValuePainter.paint(canvas, middleForValueText);

    final TextPainter textMinPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: unit.string, //th: ${theta}',
        style: theme.textTheme.bodyMedium,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textMinPainter.paint(
      canvas,
      Offset(
        centerPoint.dx - (textMinPainter.width / 2),
        centerPoint.dy +
            (textDurationValuePainter.height / 2) -
            textMinPainter.height / 2,
      ),
    );

    // Draw an arc around the circle for the amount
    // of the circle that has elapsed.
    final Paint elapsedPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = accentColor.withOpacity(0.3)
      ..isAntiAlias = true
      ..strokeWidth = radius * 0.12;

    canvas.drawArc(
      Rect.fromCircle(
        center: centerPoint,
        radius: radius - radius * 0.12 / 2,
      ),
      startAngle,
      sweep * pctTheta,
      false,
      elapsedPainter,
    );

    _paintLabels(labels, canvas, center, radius);
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) {
    return oldDelegate.labels != labels ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.theta != theta;
  }

  // Get the offset point for an angle value of theta
  // and a distance of _radius.
  Offset _getOffsetForTheta(Offset center, double theta, double radius) {
    return center + Offset(radius * math.cos(theta), -radius * math.sin(theta));
  }

  // Paint the labels (the minute strings)
  void _paintLabels(
    List<TextPainter> labels,
    Canvas canvas,
    Offset center,
    double radius,
  ) {
    final double labelThetaIncrement = -_kTwoPi / labels.length;
    double labelTheta = _kPiByTwo;

    for (final TextPainter label in labels) {
      final Offset labelOffset =
          Offset(-label.width / 2.0, -label.height / 2.0);

      label.paint(
        canvas,
        _getOffsetForTheta(center, labelTheta, radius - 40.0) + labelOffset,
      );

      labelTheta += labelThetaIncrement;
    }
  }
}

/// An enum containing the possible units for the [DurationPicker].
enum DurationPickerUnit {
  millisecond,
  second,
  minute,
  hour,
}

extension on DurationPickerUnit {
  String get string {
    switch (this) {
      case DurationPickerUnit.millisecond:
        return 'ms.';
      case DurationPickerUnit.second:
        return 'sec.';
      case DurationPickerUnit.minute:
        return 'min.';
      case DurationPickerUnit.hour:
        return 'hr.';
    }
  }

  String get secondaryString {
    switch (this) {
      case DurationPickerUnit.millisecond:
        return 's ';
      case DurationPickerUnit.second:
        return 'm ';
      case DurationPickerUnit.minute:
        return 'h ';
      case DurationPickerUnit.hour:
        return 'd ';
    }
  }

  /// Gets the relation between the base unit
  /// and the secondary unit, which is the unit
  /// just greater than the base unit.
  /// For example if the base unit is second,
  /// it will get the number of seconds in a minute.
  int get secondaryFactor {
    switch (this) {
      case DurationPickerUnit.millisecond:
        return Duration.millisecondsPerSecond;
      case DurationPickerUnit.second:
        return Duration.secondsPerMinute;
      case DurationPickerUnit.minute:
        return Duration.minutesPerHour;
      case DurationPickerUnit.hour:
        return Duration.hoursPerDay;
    }
  }

  String durationString(Duration duration) {
    switch (this) {
      case DurationPickerUnit.millisecond:
        return duration.inMilliseconds.toString();
      case DurationPickerUnit.second:
        return duration.inSeconds.toString();
      case DurationPickerUnit.minute:
        return duration.inMinutes.toString();
      case DurationPickerUnit.hour:
        return duration.inHours.toString();
    }
  }

  /// Converts the duration to the chosen base unit.
  /// For example, for base unit minutes,
  /// this gets the number of minutes in the duration.
  int durationBase(Duration duration) {
    switch (this) {
      case DurationPickerUnit.millisecond:
        return duration.inMilliseconds;
      case DurationPickerUnit.second:
        return duration.inSeconds;
      case DurationPickerUnit.minute:
        return duration.inMinutes;
      case DurationPickerUnit.hour:
        return duration.inHours;
    }
  }

  /// Converts the duration to the chosen secondary unit.
  /// For example, for base unit minutes,
  /// this gets the number of hours in the duration.
  int durationSecondary(Duration duration) {
    switch (this) {
      case DurationPickerUnit.millisecond:
        return duration.inSeconds;
      case DurationPickerUnit.second:
        return duration.inMinutes;
      case DurationPickerUnit.minute:
        return duration.inHours;
      case DurationPickerUnit.hour:
        return duration.inDays;
    }
  }

  Duration toDuration(double value) {
    final int unitFactor = secondaryFactor;

    switch (this) {
      case DurationPickerUnit.millisecond:
        return Duration(
          seconds: value ~/ unitFactor,
          milliseconds: (value % unitFactor.toDouble()).toInt(),
        );
      case DurationPickerUnit.second:
        return Duration(
          minutes: value ~/ unitFactor,
          seconds: (value % unitFactor.toDouble()).toInt(),
        );
      case DurationPickerUnit.minute:
        return Duration(
          hours: value ~/ unitFactor,
          minutes: (value % unitFactor.toDouble()).toInt(),
        );
      case DurationPickerUnit.hour:
        return Duration(
          days: value ~/ unitFactor,
          hours: (value % unitFactor.toDouble()).toInt(),
        );
    }
  }

  List<Duration> get valueMarkers {
    switch (this) {
      case DurationPickerUnit.millisecond:
        const int interval = 100;
        const int factor = Duration.millisecondsPerSecond;
        const int length = factor ~/ interval;
        return List<Duration>.generate(
          length,
          (int index) => Duration(milliseconds: index * interval),
        );
      case DurationPickerUnit.second:
        const int interval = 5;
        const int factor = Duration.secondsPerMinute;
        const int length = factor ~/ interval;
        return List<Duration>.generate(
          length,
          (int index) => Duration(seconds: index * interval),
        );
      case DurationPickerUnit.minute:
        const int interval = 5;
        const int factor = Duration.minutesPerHour;
        const int length = factor ~/ interval;
        return List<Duration>.generate(
          length,
          (int index) => Duration(minutes: index * interval),
        );
      case DurationPickerUnit.hour:
        const int interval = 3;
        const int factor = Duration.hoursPerDay;
        const int length = factor ~/ interval;
        return List<Duration>.generate(
          length,
          (int index) => Duration(hours: index * interval),
        );
    }
  }
}
