part of flutter_widgetz;

/// {@template flutter_widgetz.CounterField}
/// The allows a user to increase or decrease a numerical value.
/// {@endtemplate}
class CounterField extends StatefulWidget {
  /// {@macro flutter_widgetz.CounterField}
  const CounterField({
    super.key,
    required this.onChanged,
    required this.value,
    this.decrementIcon = Icons.remove_circle,
    this.errorText = '',
    this.hasError = false,
    this.incrementIcon = Icons.add_circle,
    this.labelText,
  });

  /// Called whenever the value changes.
  final ValueChanged<int> onChanged;

  /// The value of this counter.
  final int value;

  /// The icon used in the decrement position.
  final IconData decrementIcon;

  /// Text show when there is an error.
  final String errorText;

  /// Determines if an error is shown.
  final bool hasError;

  /// The icon used in the increment position.
  final IconData incrementIcon;

  /// Optional text that describes the input field.
  final String? labelText;

  @override
  State<CounterField> createState() => _CounterFieldState();
}

class _CounterFieldState extends State<CounterField> {
  late FocusNode _focusNode;
  late int _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Focus(
      focusNode: _focusNode,
      onFocusChange: _onFocusChange,
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          errorText: widget.hasError ? widget.errorText : null,
          labelText: widget.labelText,
          prefixIcon: InkWell(
            child: Icon(widget.decrementIcon),
            onTap: () => _onTap(--_value),
          ),
          suffixIcon: InkWell(
            child: Icon(widget.incrementIcon),
            onTap: () => _onTap(++_value),
          ),
        ),
        child: Text(
          _value.toString(),
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onTap(int value) {
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
