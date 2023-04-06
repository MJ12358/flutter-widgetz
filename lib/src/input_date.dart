part of flutter_widgetz;

class CustomInputDate extends StatelessWidget {
  const CustomInputDate({
    Key? key,
    required this.onChanged,
    this.displayStringForDate = _defaultStringForDate,
    this.errorText,
    this.firstDate,
    this.labelText,
    this.lastDate,
    this.prefixIcon,
    this.showError = false,
    this.value,
  }) : super(key: key);

  final ValueChanged<DateTime> onChanged;
  final String Function(DateTime?) displayStringForDate;
  final String? errorText;
  final DateTime? firstDate;
  final String? labelText;
  final DateTime? lastDate;
  final IconData? prefixIcon;
  final bool showError;
  final DateTime? value;

  static String _defaultStringForDate(DateTime? date) {
    return date?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(context),
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: showError ? errorText : null,
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
        ),
        child: Text(
          displayStringForDate(value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
    ).then((DateTime? value) {
      if (value != null) {
        onChanged(value);
      }
    });
  }
}
