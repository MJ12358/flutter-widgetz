part of flutter_widgetz;

class CustomInputCheckbox extends StatelessWidget {
  const CustomInputCheckbox({
    Key? key,
    required this.labelText,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String labelText;
  final bool value;
  final ValueChanged<bool> onChanged;

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
