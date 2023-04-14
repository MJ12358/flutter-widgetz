part of flutter_widgetz;

/// {@template flutter_widgetz.DateInput}
/// Wraps a call to [showDatePicker] in
/// an [InputDecorator] and [InkWell].
/// {@endtemplate}
class DateInput extends StatefulWidget {
  /// {@macro flutter_widgetz.DateInput}
  const DateInput({
    Key? key,
    required this.onChanged,
    this.displayStringForDate = _defaultStringForDate,
    this.errorText,
    this.firstDate,
    this.labelText,
    this.lastDate,
    this.prefixIcon = Icons.date_range,
    this.showError = false,
    this.value,
  }) : super(key: key);

  /// Called whenever the value changes.
  final ValueChanged<DateTime> onChanged;

  /// The string that is displayed in the input.
  final String Function(DateTime?) displayStringForDate;

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
  final DateTime? value;

  static String _defaultStringForDate(DateTime? date) {
    return date?.toString() ?? '';
  }

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late DateTime? _value;

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
          widget.displayStringForDate(_value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _value ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate:
          widget.lastDate ?? DateTime.now().add(const Duration(days: 365)),
    ).then(_handleChange);
  }

  void _handleChange(DateTime? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }
}
