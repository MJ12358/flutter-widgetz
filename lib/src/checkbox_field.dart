part of flutter_widgetz;

/// {@template flutter_widgetz.CheckboxField}
/// Wraps a [Checkbox] with an [InputDecorator] and [InkWell]
/// to provide a fully clickable input.
/// {@endtemplate}
class CheckboxField extends StatefulWidget {
  /// {@macro flutter_widgetz.CheckboxField}
  const CheckboxField({
    super.key,
    required this.onChanged,
    required this.value,
    this.child = const Text(''),
    this.labelText,
  });

  /// Called when the value of the checkbox changed.
  final ValueChanged<bool> onChanged;

  /// Whether this checkbox is checked.
  final bool value;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Optional text that describes the input field.
  final String? labelText;

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onInputTap,
      child: InputDecorator(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Checkbox(
            value: _value,
            onChanged: _onCheckboxTap,
          ),
        ),
        child: widget.child,
      ),
    );
  }

  void _onCheckboxTap(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  void _onInputTap() {
    setState(() {
      _value = !_value;
    });
    widget.onChanged(_value);
  }
}
