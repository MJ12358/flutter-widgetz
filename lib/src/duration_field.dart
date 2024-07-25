part of flutter_widgetz;

/// {@template flutter_widgetz.DurationField}
/// Wraps a call to [showDialog]->[DurationPicker]
/// in an [InputDecorator] and [InkWell].
/// {@endtemplate}
class DurationField extends StatefulWidget {
  /// {@macro flutter_widgetz.DurationField}
  const DurationField({
    super.key,
    required this.onChanged,
    this.acceptText = 'Accept',
    this.cancelText = 'Cancel',
    this.displayStringForDuration = _defaultStringForDuration,
    this.labelText = 'Duration',
    this.prefixIcon = const Icon(Icons.timelapse),
    this.snapToMins,
    this.unit,
    this.value,
  });

  /// The text used in the accept button.
  final String acceptText;

  /// The text used in the cancel button.
  final String cancelText;

  /// The string that is displayed in the input.
  final String Function(Duration?) displayStringForDuration;

  /// Optional text that describes the input field.
  final String labelText;

  /// Called whenever the value changes.
  final ValueChanged<Duration> onChanged;

  /// An icon that appears before the editable part of the text field.
  final Widget prefixIcon;

  /// The resolution of mins of the dial,
  /// i.e. if snapToMins = 5,
  /// only durations of 5min intervals will be selectable.
  final int? snapToMins;

  /// The unit for the picker.
  final DurationPickerUnit? unit;

  /// The value of this input.
  final Duration? value;

  static String _defaultStringForDuration(Duration? duration) {
    return duration?.toString() ?? '';
  }

  @override
  State<DurationField> createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
  late final FocusNode _focusNode;
  Duration? _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(DurationField oldWidget) {
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
      onTap: () => _showModal(context),
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
        ),
        child: Text(
          widget.displayStringForDuration(_value),
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: _onCancel,
              child: Text(widget.cancelText),
            ),
            TextButton(
              onPressed: _onAccept,
              child: Text(widget.acceptText),
            ),
          ],
          content: DurationPicker(
            onChanged: (Duration value) => _value = value,
            unit: widget.unit,
            value: _value,
            snapToMins: widget.snapToMins,
          ),
        );
      },
    ).then((_) => _onFocusChange(true));
  }

  void _onAccept() {
    final Duration value = _value ?? Duration.zero;
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
    _onPop();
  }

  void _onCancel() {
    setState(() {
      _value = widget.value;
    });
    _onPop();
  }

  void _onPop() {
    Navigator.of(context).pop();
    _onFocusChange(true);
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
