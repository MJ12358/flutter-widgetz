part of flutter_widgetz;

/// {@template flutter_widgetz.DateRangeInput}
/// Wraps a call to [showDateRangePicker] in
/// an [InputDecorator] and [InkWell].
/// {@endtemplate}
class DateRangeInput extends StatefulWidget {
  /// {@macro flutter_widgetz.DateRangeInput}
  const DateRangeInput({
    super.key,
    required this.onChanged,
    this.displayStringForDateRange = _defaultStringForDateRange,
    this.errorText,
    this.firstDate,
    this.labelText,
    this.lastDate,
    this.prefixIcon = Icons.date_range,
    this.showError = false,
    this.value,
  });

  /// Called whenever the value changes.
  final ValueChanged<DateTimeRange> onChanged;

  /// The string that is displayed in the input.
  final String Function(DateTimeRange?) displayStringForDateRange;

  /// The text shown when there is an error.
  final String? errorText;

  /// The first date of the date picker.
  final DateTime? firstDate;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The last date of the date picker.
  final DateTime? lastDate;

  /// An icon that appears before the editable part of the text field.
  final IconData prefixIcon;

  /// Determines if a error should be shown.
  final bool showError;

  /// The value of this input.
  final DateTimeRange? value;

  static String _defaultStringForDateRange(DateTimeRange? dateRange) {
    return dateRange?.toString() ?? '';
  }

  @override
  State<DateRangeInput> createState() => _DateRangeInputState();
}

class _DateRangeInputState extends State<DateRangeInput> {
  DateTimeRange? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(context),
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: widget.showError ? widget.errorText : null,
          labelText: widget.labelText,
          prefixIcon: Icon(widget.prefixIcon),
        ),
        child: Text(
          widget.displayStringForDateRange(_value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDateRangePicker(
      context: context,
      initialDateRange: _value,
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate:
          widget.lastDate ?? DateTime.now().add(const Duration(days: 365)),
    ).then(_onChange);
  }

  void _onChange(DateTimeRange? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }
}
