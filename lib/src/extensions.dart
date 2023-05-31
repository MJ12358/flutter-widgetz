part of flutter_widgetz;

extension _ColorExtension on Color {
  /// Determine if a color is `light` or `dark`.
  Brightness get brightness {
    final double relativeLuminance = computeLuminance();
    const double threshold = 0.45;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > threshold) {
      return Brightness.light;
    }
    return Brightness.dark;
  }

  /// Get black or white based on the brightness of this color.
  Color get blackOrWhite {
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
}

extension _DurationExtension on Duration {
  static const int daysPerYear = 365;
  static const int daysPerWeek = 7;

  int get days => (inDays % daysPerYear) % daysPerWeek;
  int get hours => inHours % Duration.hoursPerDay;
  int get minutes => inMinutes % Duration.minutesPerHour;
  int get seconds => inSeconds % Duration.secondsPerMinute;
}
