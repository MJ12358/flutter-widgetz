part of flutter_widgetz;

/// {@template flutter_widgetz.TimeField}
/// Wraps a call to [showTimePicker] in
/// an [InputDecorator] and [InkWell].
///
///![TimeField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/time_field.png)
/// {@endtemplate}
class TimeField extends StatefulWidget {
  /// {@macro flutter_widgetz.TimeField}
  const TimeField({
    super.key,
    required this.onChanged,
    this.displayStringForTime = _defaultStringForTime,
    this.entryMode = TimePickerEntryMode.dial,
    this.errorText,
    this.hasError = false,
    this.labelText,
    this.prefixIcon = const Icon(Icons.timelapse),
    this.use24HourFormat = false,
    this.value,
  });

  /// Called whenever the value changes.
  final ValueChanged<TimeOfDay> onChanged;

  /// The string that is displayed in the input.
  final String Function(TimeOfDay?) displayStringForTime;

  /// Represents the [TimePickerEntryMode].
  final TimePickerEntryMode entryMode;

  /// The text shown when there is an error.
  final String? errorText;

  /// Determines if a error should be shown.
  final bool hasError;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final Widget prefixIcon;

  /// Determines whether to use a 24-hour format.
  final bool use24HourFormat;

  /// The value of this input.
  final TimeOfDay? value;

  static String _defaultStringForTime(TimeOfDay? time) {
    return time?.toString() ?? '';
  }

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  late final FocusNode _focusNode;
  TimeOfDay? _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(TimeField oldWidget) {
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
      onTap: () => _showTimePicker(context),
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          errorText: widget.hasError ? widget.errorText : null,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
        ),
        child: Text(
          widget.displayStringForTime(_value),
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialEntryMode: widget.entryMode,
      initialTime: _value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: widget.use24HourFormat,
          ),
          child: child!,
        );
      },
    ).then(_onChange);
  }

  void _onChange(TimeOfDay? value) {
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
