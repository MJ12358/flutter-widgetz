part of flutter_widgetz;

extension _ColorExtension on Color {
  Brightness get brightness {
    return ThemeData.estimateBrightnessForColor(this);
  }

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

extension _StringExtension on String {
  bool get isUri {
    return Uri.tryParse(this)?.isAbsolute ?? false;
  }

  bool get isBase64 {
    return RegExp(
      r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$',
    ).hasMatch(this);
  }
}
