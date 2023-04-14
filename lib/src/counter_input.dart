part of flutter_widgetz;

/// {@template flutter_widgetz.CounterInput}
/// The allows a user to increase or decrease a numerical value.
/// {@endtemplate}
class CounterInput extends StatefulWidget {
  /// {@macro flutter_widgetz.CounterInput}
  const CounterInput({
    Key? key,
    required this.onChanged,
    required this.value,
    this.decrementIcon = Icons.remove_circle,
    this.errorText = '',
    this.incrementIcon = Icons.add_circle,
    this.labelText,
    this.showError = false,
  }) : super(key: key);

  /// Called whenever the value changes.
  final ValueChanged<int> onChanged;

  /// The value of this counter.
  final int value;

  /// The icon used in the decrement position.
  final IconData decrementIcon;

  /// Text show when there is an error.
  final String errorText;

  /// The icon used in the increment position.
  final IconData incrementIcon;

  /// Optional text that describes the input field.
  final String? labelText;

  /// Determines if an error is shown.
  final bool showError;

  @override
  State<CounterInput> createState() => _CounterInputState();
}

class _CounterInputState extends State<CounterInput> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        errorText: widget.showError ? widget.errorText : null,
        labelText: widget.labelText,
        prefixIcon: InkWell(
          child: Icon(widget.decrementIcon),
          onTap: () => _handleTap(--_value),
        ),
        suffixIcon: InkWell(
          child: Icon(widget.incrementIcon),
          onTap: () => _handleTap(++_value),
        ),
      ),
      child: Text(
        _value.toString(),
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleTap(int value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }
}
