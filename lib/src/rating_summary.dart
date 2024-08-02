part of flutter_widgetz;

/// {@template flutter_widgetz.RatingSummary}
/// A rating summary widget.
///
/// Inspired by Google's "Audience rating summary".
///
///![RatingSummary](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/rating_summary.png)
/// {@endtemplate}
class RatingSummary extends StatelessWidget {
  /// {@macro flutter_widgetz.RatingSummary}
  const RatingSummary({
    super.key,
    this.backgroundColor,
    this.borderRadius = 0,
    this.color,
    this.fiveStarCount = 0,
    this.fiveStarLabel = const Text('5'),
    this.fourStarCount = 0,
    this.fourStarLabel = const Text('4'),
    this.threeStarCount = 0,
    this.threeStarLabel = const Text('3'),
    this.twoStarCount = 0,
    this.twoStarLabel = const Text('2'),
    this.oneStarCount = 0,
    this.oneStarLabel = const Text('1'),
    this.height = 10,
    this.rating,
    this.spacing = 4.0,
  });

  /// The color used as a background for the indicators.
  final Color? backgroundColor;

  /// The radii for each corner.
  final double borderRadius;

  /// The color of the indicators.
  final Color? color;

  /// The five star rating count.
  final num fiveStarCount;

  /// The five star label.
  final Widget fiveStarLabel;

  /// The four star rating count.
  final num fourStarCount;

  /// The four star label.
  final Widget fourStarLabel;

  /// The three star rating count.
  final num threeStarCount;

  /// The three star label.
  final Widget threeStarLabel;

  /// The two star rating count.
  final num twoStarCount;

  /// The two star label.
  final Widget twoStarLabel;

  /// The one star rating count.
  final num oneStarCount;

  /// The one star label.
  final Widget oneStarLabel;

  /// The height of the indicators.
  final double height;

  /// The overall rating. Optional, if not given we
  /// will calculate the overall rating for you.
  final num? rating;

  /// The spacing between the indicators.
  final double spacing;

  num get _rating {
    num count = 0;
    num sum = 0;
    final List<num> values = <num>[
      oneStarCount,
      twoStarCount,
      threeStarCount,
      fourStarCount,
      fiveStarCount,
    ];
    for (int i = 0; i < values.length; i++) {
      count += values[i];
      sum += values[i] * (i + 1);
    }
    return sum / count;
  }

  num get _total {
    return <num>[
      fiveStarCount,
      fourStarCount,
      threeStarCount,
      twoStarCount,
      oneStarCount,
    ].reduce((num v, num e) => v + e);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: SpacedColumn(
            spacer: SizedBox(height: spacing),
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _RatingIndicator(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                color: color,
                height: height,
                title: fiveStarLabel,
                total: _total,
                value: fiveStarCount,
              ),
              _RatingIndicator(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                color: color,
                height: height,
                title: fourStarLabel,
                total: _total,
                value: fourStarCount,
              ),
              _RatingIndicator(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                color: color,
                height: height,
                title: threeStarLabel,
                total: _total,
                value: threeStarCount,
              ),
              _RatingIndicator(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                color: color,
                height: height,
                title: twoStarLabel,
                total: _total,
                value: twoStarCount,
              ),
              _RatingIndicator(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                color: color,
                height: height,
                title: oneStarLabel,
                total: _total,
                value: oneStarCount,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Flexible(
          flex: 0,
          child: _RatingSummary(
            color: color,
            rating: rating ?? _rating,
            total: _total,
          ),
        ),
      ],
    );
  }
}

class _RatingIndicator extends StatelessWidget {
  const _RatingIndicator({
    required this.borderRadius,
    required this.height,
    required this.title,
    required this.total,
    required this.value,
    this.backgroundColor,
    this.color,
  });

  final double borderRadius;
  final double height;
  final Widget title;
  final num total;
  final num value;
  final Color? backgroundColor;
  final Color? color;

  double get _percentage {
    return (value / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        title,
        const SizedBox(width: 8.0),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CustomProgressIndicator.linear(
              backgroundColor: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              color: color,
              minHeight: height,
              value: _percentage,
            ),
          ),
        ),
      ],
    );
  }
}

class _RatingSummary extends StatelessWidget {
  const _RatingSummary({
    required this.color,
    required this.rating,
    required this.total,
  });

  final Color? color;
  final num rating;
  final num total;

  String get _ratingsText {
    if (total == 1) {
      return 'rating';
    } else {
      return 'ratings';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SpacedColumn(
      mainAxisSize: MainAxisSize.min,
      spacer: const SizedBox(height: 8.0),
      children: <Widget>[
        Text(
          rating.toStringAsFixed(1),
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        RatingBar(
          color: color,
          size: 10,
          value: rating,
        ),
        Text(
          '$total $_ratingsText',
        ),
      ],
    );
  }
}
