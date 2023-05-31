part of flutter_widgetz;

/// {@template flutter_widgetz.Countdown}
/// A widget that counts down from the given [target].
/// {@endtemplate}
class Countdown extends StatefulWidget {
  /// {@macro flutter_widgetz.Countdown}
  Countdown({
    super.key,
    required this.target,
    Color? backgroundColor,
    Widget? daysLabel,
    String daysText = _defaultDaysText,
    Widget? hoursLabel,
    String hoursText = _defaultHoursText,
    Widget? minutesLabel,
    String minutesText = _defaultMinutesText,
    Widget? secondsLabel,
    String secondsText = _defaultSecondsText,
    this.separator = _defaultSeparator,
    ShapeBorder shape = const RoundedRectangleBorder(),
    this.textColor,
  })  : daysLabel = daysLabel ?? Text(daysText),
        hoursLabel = hoursLabel ?? Text(hoursText),
        minutesLabel = minutesLabel ?? Text(minutesText),
        secondsLabel = secondsLabel ?? Text(secondsText),
        decoration = ShapeDecoration(
          color: backgroundColor ?? _defaultBackgroundColor,
          shape: shape,
        );

  /// The target datetime from which to countdown.
  final DateTime target;

  /// The label given to the days.
  final Widget daysLabel;

  /// A decoration given to each unit.
  final ShapeDecoration decoration;

  /// The label given to the hours.
  final Widget hoursLabel;

  /// The label given to the minutes.
  final Widget minutesLabel;

  /// The label given to the seconds.
  final Widget secondsLabel;

  /// A widget separating the different units.
  final Widget separator;

  /// The color of the units value.
  final Color? textColor;

  static const String _defaultDaysText = 'Days';
  static const String _defaultHoursText = 'Hours';
  static const String _defaultMinutesText = 'Mins';
  static const String _defaultSecondsText = 'Secs';
  static const Widget _defaultSeparator = Text(':');
  static final Color _defaultBackgroundColor = Colors.grey.shade200;

  /// {@macro flutter_widgetz.Countdown}
  ///
  /// Circular uses a box decoration with [BoxShape.circle].
  Countdown.circular({
    super.key,
    required this.target,
    Color? backgroundColor,
    Widget? daysLabel,
    String daysText = _defaultDaysText,
    Widget? hoursLabel,
    String hoursText = _defaultHoursText,
    Widget? minutesLabel,
    String minutesText = _defaultMinutesText,
    Widget? secondsLabel,
    String secondsText = _defaultSecondsText,
    this.separator = _defaultSeparator,
    this.textColor,
  })  : daysLabel = daysLabel ?? Text(daysText),
        hoursLabel = hoursLabel ?? Text(hoursText),
        minutesLabel = minutesLabel ?? Text(minutesText),
        secondsLabel = secondsLabel ?? Text(secondsText),
        decoration = ShapeDecoration.fromBoxDecoration(
          BoxDecoration(
            color: backgroundColor ?? _defaultBackgroundColor,
            shape: BoxShape.circle,
          ),
        );

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _duration = widget.target.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = widget.target.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.daysLabel,
          value: _duration.days,
        ),
        _Separator(
          color: widget.textColor,
          child: widget.separator,
        ),
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.hoursLabel,
          value: _duration.hours,
        ),
        _Separator(
          color: widget.textColor,
          child: widget.separator,
        ),
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.minutesLabel,
          value: _duration.minutes,
        ),
        _Separator(
          color: widget.textColor,
          child: widget.separator,
        ),
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.secondsLabel,
          value: _duration.seconds,
        ),
      ],
    );
  }
}

class _Digit extends StatelessWidget {
  const _Digit({
    required this.decoration,
    required this.unit,
    required this.value,
    this.color,
  });

  final ShapeDecoration decoration;
  final Widget unit;
  final num value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Container(
        decoration: decoration,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                value.toString(),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: color ?? theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              DefaultTextStyle(
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: decoration.color?.blackOrWhite,
                ),
                child: IconTheme(
                  data: theme.iconTheme.copyWith(
                    color: decoration.color?.blackOrWhite,
                  ),
                  child: unit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    required this.child,
    this.color,
  });

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.titleLarge!.copyWith(
        color: color ?? theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
