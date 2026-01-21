part of flutter_widgetz;

/// {@template flutter_widgetz.DateTimeField}
/// Wraps a calls to [showDatePicker]
/// then [showTimePicker] in
/// an [InputDecorator] and [InkWell].
///
///![DateTimeField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/datetime_field.png)
/// {@endtemplate}
class DateTimeField extends StatefulWidget {
  /// {@macro flutter_widgetz.DateTimeField}
  const DateTimeField({
    super.key,
    required this.onChanged,
    this.dateEntryMode = DatePickerEntryMode.calendar,
    this.datePickerMode = DatePickerMode.day,
    this.displayStringForDate = _defaultStringForDate,
    this.errorText,
    this.firstDate,
    this.hasError = false,
    this.labelText,
    this.lastDate,
    this.prefixIcon = const Icon(Icons.calendar_month),
    this.skipDateEntry = false,
    this.timeEntryMode = TimePickerEntryMode.dial,
    this.use24HourFormat = false,
    this.value,
  });

  /// Called whenever the value changes.
  final ValueChanged<DateTime> onChanged;

  /// The string that is displayed in the input.
  final String Function(DateTime?) displayStringForDate;

  /// Represents the [DatePickerEntryMode].
  final DatePickerEntryMode dateEntryMode;

  /// Represents the [DatePickerMode].
  final DatePickerMode datePickerMode;

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

  /// Determines whether to skip the date portion of this DateTime.
  final bool skipDateEntry;

  /// Represents the [TimePickerEntryMode].
  final TimePickerEntryMode timeEntryMode;

  /// Determines whether to use a 24 hour format clock.
  final bool use24HourFormat;

  /// The value of this input.
  final DateTime? value;

  static String _defaultStringForDate(DateTime? date) {
    return date?.toString() ?? '';
  }

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  late final FocusNode _focusNode;
  DateTime? _value;

  DateTime get _defaultInitialDate => DateTime.now();
  DateTime get _defaultFirstDate => DateTime.fromMillisecondsSinceEpoch(0);
  DateTime get _defaultLastDate => DateTime(DateTime.now().year + 100);
  TimeOfDay get _defaultInitialTime => _value != null
      ? TimeOfDay(hour: _value!.hour, minute: _value!.minute)
      : TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(DateTimeField oldWidget) {
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

    return Semantics(
      identifier: widget.labelText,
      child: InkWell(
        focusNode: _focusNode,
        onFocusChange: _onFocusChange,
        onTap: () => _showPickers(context),
        child: InputDecorator(
          isEmpty: _value == null,
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
      ),
    );
  }

  Future<void> _showPickers(BuildContext context) async {
    DateTime? dt = _defaultInitialDate;
    if (!widget.skipDateEntry) {
      dt = await showDatePicker(
        context: context,
        initialDate: _value ?? _defaultInitialDate,
        firstDate: widget.firstDate ?? _defaultFirstDate,
        lastDate: widget.lastDate ?? _defaultLastDate,
        initialDatePickerMode: widget.datePickerMode,
        initialEntryMode: widget.dateEntryMode,
      );
      if (dt == null) {
        return;
      }
    }
    if (!context.mounted) {
      return;
    }
    final TimeOfDay? tod = await showTimePicker(
      context: context,
      initialEntryMode: widget.timeEntryMode,
      initialTime: _defaultInitialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: widget.use24HourFormat,
          ),
          child: child!,
        );
      },
    );
    if (tod != null) {
      dt = dt.copyWith(
        hour: tod.hour,
        minute: tod.minute,
      );
    }
    _onChange(dt);
  }

  void _onChange(DateTime value) {
    _onFocusChange(true);
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
