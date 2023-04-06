part of flutter_widgetz;

class CustomInputDropdown<T extends Object> extends StatelessWidget {
  const CustomInputDropdown({
    Key? key,
    required this.items,
    required this.labelText,
    required this.onChanged,
    required this.displayStringForItem,
    this.isDense = true,
    this.prefixIcon,
    this.value,
  }) : super(key: key);

  final Iterable<T> items;
  final String labelText;
  final ValueChanged<T> onChanged;
  final Function(T) displayStringForItem;
  final bool isDense;
  final IconData? prefixIcon;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isDense: isDense,
          onChanged: (T? v) {
            if (v != null) {
              onChanged(v);
            }
          },
          items: _getItems(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>> _getItems() {
    return items.map(
      (T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(displayStringForItem(item)),
        );
      },
    ).toList();
  }
}
