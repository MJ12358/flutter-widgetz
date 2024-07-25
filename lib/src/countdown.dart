part of flutter_widgetz;

/// {@template flutter_widgetz.Countdown}
/// A widget that counts down from the given [target].
///
///![Countdown](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/countdown.png)
/// {@endtemplate}
class Countdown extends StatefulWidget {
  /// {@macro flutter_widgetz.Countdown}
  const Countdown({
    super.key,
    required this.target,
    required this.decoration,
    this.daysLabel = _defaultDaysLabel,
    this.hoursLabel = _defaultHoursLabel,
    this.minutesLabel = _defaultMinutesLabel,
    this.secondsLabel = _defaultSecondsLabel,
    this.separator = _defaultSeparator,
    this.textColor,
    this.timer,
    this.onDone,
  });

  /// The target datetime from which to countdown.
  final DateTime target;

  /// A decoration given to each unit.
  final BoxDecoration decoration;

  /// The label given to the days.
  final Widget daysLabel;

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

  /// An optional timer if you do not want to use the build in timer.
  final Timer? timer;

  /// Called when the countdown is done.
  final VoidCallback? onDone;

  static const Widget _defaultDaysLabel = Text('Days');
  static const Widget _defaultHoursLabel = Text('Hours');
  static const Widget _defaultMinutesLabel = Text('Mins');
  static const Widget _defaultSecondsLabel = Text('Secs');
  static const Widget _defaultSeparator = Text(':');
  static final Color _defaultBackgroundColor = Colors.grey.shade200;

  /// {@macro flutter_widgetz.Countdown}
  ///
  /// Circular uses a box decoration with [BoxShape.circle].
  Countdown.circle({
    super.key,
    required this.target,
    Color? backgroundColor,
    this.daysLabel = _defaultDaysLabel,
    this.hoursLabel = _defaultHoursLabel,
    this.minutesLabel = _defaultMinutesLabel,
    this.secondsLabel = _defaultSecondsLabel,
    this.separator = _defaultSeparator,
    this.textColor,
    this.timer,
    this.onDone,
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
    this.daysLabel = _defaultDaysLabel,
    this.hoursLabel = _defaultHoursLabel,
    this.minutesLabel = _defaultMinutesLabel,
    this.secondsLabel = _defaultSecondsLabel,
    this.separator = _defaultSeparator,
    this.textColor,
    this.timer,
    this.onDone,
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
    _timer = widget.timer ?? _initTimer();
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

  Timer _initTimer() {
    return Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_hasEnded) {
        timer.cancel();
        widget.onDone?.call();
      }
      setState(() {
        _duration = widget.target.difference(DateTime.now());
      });
    });
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
              DefaultTextStyle.merge(
                style: theme.textTheme.bodyMedium?.copyWith(
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

    return DefaultTextStyle.merge(
      style: theme.textTheme.titleLarge?.copyWith(
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
