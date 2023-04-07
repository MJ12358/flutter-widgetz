part of flutter_widgetz;

/// Wraps a [Checkbox] with an [InputDecorator] and [InkWell]
/// to provide a fully clickable input.
class CustomInputCheckbox extends StatelessWidget {
  const CustomInputCheckbox({
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: InputDecorator(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Checkbox(
            value: value,
            onChanged: (bool? value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ),
      ),
    );
  }
}
