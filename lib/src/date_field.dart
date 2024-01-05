part of flutter_widgetz;

/// {@template flutter_widgetz.DateField}
/// Wraps a call to [showDatePicker] in
/// an [InputDecorator] and [InkWell].
/// {@endtemplate}
class DateField extends StatefulWidget {
  /// {@macro flutter_widgetz.DateField}
  const DateField({
    super.key,
    required this.onChanged,
    this.displayStringForDate = _defaultStringForDate,
    this.errorText,
    this.firstDate,
    this.hasError = false,
    this.labelText,
    this.lastDate,
    this.prefixIcon = const Icon(Icons.calendar_month),
    this.value,
  });

  /// Called whenever the value changes.
  final ValueChanged<DateTime> onChanged;

  /// The string that is displayed in the input.
  final String Function(DateTime?) displayStringForDate;

  /// The text shown when there is an error.
  final String? errorText;

  /// The first date of the date picker.
  ///
  /// This defaults to [DateTime.now].
  final DateTime? firstDate;

  /// Determines if a error should be shown.
  final bool hasError;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The last date of the date picker.
  ///
  /// This defaults to [DateTime.now.add(Duration(days: 365))].
  final DateTime? lastDate;

  /// An icon that appears before the editable part of the text field.
  final Widget prefixIcon;

  /// The value of this input.
  final DateTime? value;

  static String _defaultStringForDate(DateTime? date) {
    return date?.toString() ?? '';
  }

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late FocusNode _focusNode;
  DateTime? _value;

  DateTime get _defaultInitialDate => DateTime.now();
  DateTime get _defaultFirstDate => DateTime.now();
  DateTime get _defaultLastDate =>
      DateTime.now().add(const Duration(days: 365));

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
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
          widget.displayStringForDate(_value),
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _value ?? _defaultInitialDate,
      firstDate: widget.firstDate ?? _defaultFirstDate,
      lastDate: widget.lastDate ?? _defaultLastDate,
    ).then(_onChange);
  }

  void _onChange(DateTime? value) {
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
