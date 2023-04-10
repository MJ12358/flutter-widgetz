part of flutter_widgetz;

/// {@template flutter_widgetz.CustomInputDropdown}
/// Wraps a [DropdownButton] in an [InputDecorator].
/// {@endtemplate}
class CustomInputDropdown<T extends Object> extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomInputDropdown}
  const CustomInputDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.displayStringForItem,
    this.isDense = true,
    this.labelText,
    this.prefixIcon,
    this.value,
  }) : super(key: key);

  /// The list of items the user can select.
  final Iterable<T> items;

  /// Called when the user selects an item.
  final ValueChanged<T> onChanged;

  /// The string that is displayed for each item.
  final Function(T) displayStringForItem;

  /// Optional text that describes the input field.
  final String? labelText;

  /// Reduce the widgets height.
  final bool isDense;

  /// An icon that appears before the editable part of the text field.
  final IconData? prefixIcon;

  /// The value of the currently selected [DropdownMenuItem].
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
