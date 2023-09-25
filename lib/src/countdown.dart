part of flutter_widgetz;

/// {@template flutter_widgetz.Countdown}
/// A widget that counts down from the given [target].
/// {@endtemplate}
class Countdown extends StatefulWidget {
  /// {@macro flutter_widgetz.Countdown}
  const Countdown({
    super.key,
    required this.target,
    required this.decoration,
    this.daysLabel,
    this.daysText = _defaultDaysText,
    this.hoursLabel,
    this.hoursText = _defaultHoursText,
    this.minutesLabel,
    this.minutesText = _defaultMinutesText,
    this.secondsLabel,
    this.secondsText = _defaultSecondsText,
    this.separator = _defaultSeparator,
    this.textColor,
  });

  /// The target datetime from which to countdown.
  final DateTime target;

  /// A decoration given to each unit.
  final BoxDecoration decoration;

  /// The label given to the days.
  final Widget? daysLabel;

  /// The text given to the days when [daysLabel] is null.
  final String daysText;

  /// The label given to the hours.
  final Widget? hoursLabel;

  /// The text given to the hours when [hoursLabel] is null.
  final String hoursText;

  /// The label given to the minutes.
  final Widget? minutesLabel;

  /// The text given to the minutes when [minutesLabel] is null.
  final String minutesText;

  /// The label given to the seconds.
  final Widget? secondsLabel;

  /// The label given to the seconds when [secondsLabel] is null.
  final String secondsText;

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
    this.daysLabel,
    this.daysText = _defaultDaysText,
    this.hoursLabel,
    this.hoursText = _defaultHoursText,
    this.minutesLabel,
    this.minutesText = _defaultMinutesText,
    this.secondsLabel,
    this.secondsText = _defaultSecondsText,
    this.separator = _defaultSeparator,
    this.textColor,
  }) : decoration = BoxDecoration(
          color: backgroundColor ?? _defaultBackgroundColor,
          shape: BoxShape.circle,
        );

  /// {@macro flutter_widgetz.Countdown}
  ///
  /// Rectangle uses a box decoration with [BoxShape.rectangle].
  Countdown.rectangle({
    super.key,
    required this.target,
    Color? backgroundColor,
    this.daysLabel,
    this.daysText = _defaultDaysText,
    this.hoursLabel,
    this.hoursText = _defaultHoursText,
    this.minutesLabel,
    this.minutesText = _defaultMinutesText,
    this.secondsLabel,
    this.secondsText = _defaultSecondsText,
    this.separator = _defaultSeparator,
    this.textColor,
  }) : decoration = BoxDecoration(
          color: backgroundColor ?? _defaultBackgroundColor,
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
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_hasEnded) {
        timer.cancel();
      }
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

  bool get _hasEnded {
    final DateTime target = widget.target;
    if (DateTime.now().isAfter(target)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.daysLabel ?? Text(widget.daysText),
          value: _duration.days,
        ),
        _Separator(
          color: widget.textColor,
          child: widget.separator,
        ),
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.hoursLabel ?? Text(widget.hoursText),
          value: _duration.hours,
        ),
        _Separator(
          color: widget.textColor,
          child: widget.separator,
        ),
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.minutesLabel ?? Text(widget.minutesText),
          value: _duration.minutes,
        ),
        _Separator(
          color: widget.textColor,
          child: widget.separator,
        ),
        _Digit(
          color: widget.textColor,
          decoration: widget.decoration,
          unit: widget.secondsLabel ?? Text(widget.secondsText),
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

  final BoxDecoration decoration;
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
                  color: color ?? theme.colorScheme.primary,
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
        color: color ?? theme.colorScheme.primary,
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
