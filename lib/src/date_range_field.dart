part of flutter_widgetz;

/// {@template flutter_widgetz.DateRangeField}
/// Wraps a call to [showDateRangePicker] in
/// an [InputDecorator] and [InkWell].
/// {@endtemplate}
class DateRangeField extends StatefulWidget {
  /// {@macro flutter_widgetz.DateRangeField}
  const DateRangeField({
    super.key,
    required this.onChanged,
    this.displayStringForDateRange = _defaultStringForDateRange,
    this.errorText,
    this.firstDate,
    this.hasError = false,
    this.labelText,
    this.lastDate,
    this.prefixIcon = const Icon(Icons.date_range),
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

  /// Determines if a error should be shown.
  final bool hasError;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The last date of the date picker.
  final DateTime? lastDate;

  /// An icon that appears before the editable part of the text field.
  final Widget prefixIcon;

  /// The value of this input.
  final DateTimeRange? value;

  static String _defaultStringForDateRange(DateTimeRange? dateRange) {
    return dateRange?.toString() ?? '';
  }

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  late FocusNode _focusNode;
  DateTimeRange? _value;

  DateTime get _defaultFirstDate => DateTime.fromMillisecondsSinceEpoch(0);
  DateTime get _defaultLastDate => DateTime(2100);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(DateRangeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      focusNode: _focusNode,
      onFocusChange: _onFocusChange,
      onTap: () => _showDatePicker(context),
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          errorText: widget.hasError ? widget.errorText : null,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
        ),
        child: Text(
          widget.displayStringForDateRange(_value),
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDateRangePicker(
      context: context,
      initialDateRange: _value,
      firstDate: widget.firstDate ?? _defaultFirstDate,
      lastDate: widget.lastDate ?? _defaultLastDate,
    ).then(_onChange);
  }

  void _onChange(DateTimeRange? value) {
    _onFocusChange(true);
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }

  void _onFocusChange(bool value) {
    if (value) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
    setState(() {});
  }
}
