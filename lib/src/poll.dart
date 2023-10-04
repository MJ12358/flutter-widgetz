part of flutter_widgetz;

/// {@template flutter_widgetz.Poll}
/// A Poll widget, similar to Twitter's.
/// {@endtemplate}
class Poll extends StatefulWidget {
  /// {@macro flutter_widgetz.Poll}
  const Poll({
    super.key,
    required this.question,
    required this.options,
    required this.onVoted,
    this.backgroundColor,
    this.borderRadius = 0,
    this.color,
    this.endDate,
    this.finalResultsText = 'Final results',
    this.hasVoted = false,
    this.height = 50,
    this.spacing = 4.0,
    this.votesText = 'Votes',
  }) : assert(options.length >= 2, 'Poll must have at least 2 options.');

  /// The question asked by this poll.
  final String question;

  /// A list of [PollOption].
  final List<PollOption> options;

  /// A callback called when an option is chosen.
  final Future<void> Function(PollOption option) onVoted;

  /// The color used as a background for the buttons and indicators.
  final Color? backgroundColor;

  /// The radii for each corner.
  final double borderRadius;

  /// The color used for the text of buttons
  /// and foreground of indicators.
  final Color? color;

  /// An optional end date for this poll.
  final DateTime? endDate;

  /// The text displaying the final results.
  final String finalResultsText;

  /// Determines if the user has already voted.
  final bool hasVoted;

  /// The height of the buttons and indicators.
  final double height;

  /// The spacing between the buttons and indicators.
  final double spacing;

  /// The text displaying the votes.
  final String votesText;

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {
  late bool _isLoading;
  late bool _hasVoted;
  late List<PollOption> _options;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _hasVoted = widget.hasVoted;
    _isLoading = false;
    _options = widget.options;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_hasEnded) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool get _hasEnded {
    final DateTime? endDate = widget.endDate;
    if (endDate != null && DateTime.now().isAfter(endDate)) {
      return true;
    }
    return false;
  }

  int get _totalVotes {
    int result = 0;
    for (int i = 0; i < _options.length; i++) {
      result += _options[i].votes;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: widget.spacing,
      children: <Widget>[
        Text(
          widget.question,
          style: theme.textTheme.titleMedium,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: (_hasEnded || _hasVoted)
              ? _PollIndicators(
                  borderRadius: widget.borderRadius,
                  height: widget.height,
                  options: _options,
                  spacing: widget.spacing,
                  totalVotes: _totalVotes,
                  backgroundColor: widget.backgroundColor,
                  color: widget.color,
                )
              : _PollButtons(
                  borderRadius: widget.borderRadius,
                  height: widget.height,
                  onVoted: _onVoted,
                  options: _options,
                  spacing: widget.spacing,
                  backgroundColor: widget.backgroundColor,
                  color: widget.color,
                ),
        ),
        _PollFooter(
          finalResultsText: widget.finalResultsText,
          hasEnded: _hasEnded,
          votesText: widget.votesText,
          totalVotes: _totalVotes,
          endDate: widget.endDate,
        ),
      ],
    );
  }

  Future<void> _onVoted(PollOption option) async {
    if (_isLoading == true) {
      return;
    }
    _isLoading = true;

    final int i = _options.indexOf(option);
    option.votes++;
    _options[i] = option;

    try {
      await widget.onVoted(option);
      setState(() {
        _hasVoted = true;
        _options = _options;
      });
    } finally {
      _isLoading = false;
    }
  }
}

class _PollButtons extends StatelessWidget {
  const _PollButtons({
    required this.borderRadius,
    required this.height,
    required this.onVoted,
    required this.options,
    required this.spacing,
    this.backgroundColor,
    this.color,
  });

  final double borderRadius;
  final double height;
  final ValueChanged<PollOption> onVoted;
  final List<PollOption> options;
  final double spacing;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing,
      children: options.map((PollOption e) {
        return _PollButton(
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          color: color,
          height: height,
          onPressed: () => onVoted(e),
          option: e,
        );
      }).toList(),
    );
  }
}

class _PollIndicators extends StatelessWidget {
  const _PollIndicators({
    required this.borderRadius,
    required this.height,
    required this.options,
    required this.spacing,
    required this.totalVotes,
    this.backgroundColor,
    this.color,
  });

  final double borderRadius;
  final double height;
  final List<PollOption> options;
  final double spacing;
  final int totalVotes;
  final Color? backgroundColor;
  final Color? color;

  PollOption get _winner {
    return options.reduce((
      PollOption current,
      PollOption next,
    ) {
      return current.votes > next.votes ? current : next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PollOption winner = _winner;

    return SpacedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing,
      children: options.map((PollOption e) {
        return _PollIndicator(
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          color: color,
          height: height,
          option: e,
          isWinning: winner == e,
          value: e.votes / totalVotes,
        );
      }).toList(),
    );
  }
}

class _PollButton extends StatelessWidget {
  const _PollButton({
    required this.borderRadius,
    required this.height,
    required this.onPressed,
    required this.option,
    this.backgroundColor,
    this.color,
  });

  final double borderRadius;
  final double height;
  final VoidCallback onPressed;
  final PollOption option;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ButtonTheme(
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: color ?? theme.colorScheme.primary),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          color: backgroundColor,
          elevation: 0.0,
          child: Text(
            option.name,
            style: theme.textTheme.labelLarge?.copyWith(
              color: color ?? theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _PollIndicator extends StatelessWidget {
  const _PollIndicator({
    required this.borderRadius,
    required this.height,
    required this.isWinning,
    required this.option,
    required this.value,
    this.backgroundColor,
    this.color,
  });

  final double borderRadius;
  final double height;
  final bool isWinning;
  final PollOption option;
  final double value;
  final Color? backgroundColor;
  final Color? color;

  String get _percentage {
    final double v = value * 100;
    final RegExp regex = RegExp(r'([.]*0+)(?!.*\d)');
    final String result = v.toStringAsFixed(1).replaceAll(regex, '');
    return '$result%';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.labelLarge!.copyWith(
        fontWeight: isWinning ? FontWeight.bold : FontWeight.normal,
      ),
      child: PercentIndicator.linear(
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        color: color,
        height: height,
        value: value,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(option.name),
            Text(_percentage),
          ],
        ),
      ),
    );
  }
}

class _PollFooter extends StatelessWidget {
  const _PollFooter({
    required this.finalResultsText,
    required this.hasEnded,
    required this.votesText,
    required this.totalVotes,
    this.endDate,
  });

  final String finalResultsText;
  final bool hasEnded;
  final String votesText;
  final int totalVotes;
  final DateTime? endDate;

  String get _formattedTime {
    if (endDate == null) {
      return '';
    }
    final DateTime now = DateTime.now();

    final Duration d = DateTime(
      endDate!.year,
      endDate!.month,
      endDate!.day,
      endDate!.hour,
      endDate!.minute,
      endDate!.second,
    ).difference(
      DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
      ),
    );

    if (d.inDays >= 1) {
      return '${d.inDays} ${d.inDays == 1 ? "day" : "days"}';
    }
    if (d.inHours >= 1) {
      return '${d.inHours} ${d.inHours == 1 ? "hour" : "hours"}';
    }
    if (d.inMinutes >= 1) {
      return '${d.inMinutes} ${d.inMinutes == 1 ? "minute" : "minutes"}';
    }

    return '${d.inSeconds} ${d.inSeconds == 1 ? "second" : "seconds"}';
  }

  @override
  Widget build(BuildContext context) {
    final String text = '$totalVotes $votesText';

    if (endDate == null) {
      return Text(text);
    }

    if (hasEnded) {
      return Text('$text • $finalResultsText');
    }

    return Text('$text • $_formattedTime');
  }
}

/// A class to hold poll option information.
class PollOption {
  PollOption({
    this.id,
    required this.name,
    required this.votes,
  });

  final String? id;
  final String name;
  int votes;
}
