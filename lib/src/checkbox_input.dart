part of flutter_widgetz;

/// {@template flutter_widgetz.CheckboxInput}
/// Wraps a [Checkbox] with an [InputDecorator] and [InkWell]
/// to provide a fully clickable input.
/// {@endtemplate}
class CheckboxInput extends StatefulWidget {
  /// {@macro flutter_widgetz.CheckboxInput}
  const CheckboxInput({
    Key? key,
    required this.onChanged,
    required this.value,
    this.labelText,
  }) : super(key: key);

  /// Called when the value of the checkbox changed.
  final ValueChanged<bool> onChanged;

  /// Whether this checkbox is checked.
  final bool value;

  /// Optional text that describes the input field.
  final String? labelText;

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleInputTap,
      child: InputDecorator(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Checkbox(
            value: _value,
            onChanged: _handleCheckboxTap,
          ),
        ),
      ),
    );
  }

  void _handleCheckboxTap(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  void _handleInputTap() {
    setState(() {
      _value = !_value;
    });
    widget.onChanged(_value);
  }
}
