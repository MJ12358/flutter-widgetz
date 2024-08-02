part of flutter_widgetz;

/// {@template flutter_widgetz.DropdownField}
/// Wraps a [DropdownButton] in an [InputDecorator].
///
///![DropdownField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/dropdown_field1.png)
///
///![DropdownField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/dropdown_field2.png)
/// {@endtemplate}
class DropdownField<T extends Object> extends StatefulWidget {
  /// {@macro flutter_widgetz.DropdownField}
  const DropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.displayStringForItem = _defaultStringForItem,
    this.icon,
    this.isDense = true,
    this.isExpanded = true,
    this.labelText = '',
    this.prefixIcon,
    this.value,
  });

  /// The list of items the user can select.
  final Iterable<T> items;

  /// Called when the user selects an item.
  final ValueChanged<T> onChanged;

  /// The string that is displayed for each item.
  final String Function(T) displayStringForItem;

  /// The drop-down button's icon.
  final Widget? icon;

  /// Reduce the widgets height.
  final bool isDense;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  final bool isExpanded;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// The value of the currently selected [DropdownMenuItem].
  final T? value;

  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T extends Object> extends State<DropdownField<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(DropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      icon: widget.icon,
      isDense: widget.isDense,
      isExpanded: widget.isExpanded,
      decoration: InputDecoration(
        isDense: widget.isDense,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
      ),
      items: _getItems(),
      onChanged: _onChange,
      value: _value,
    );
  }

  List<DropdownMenuItem<T>> _getItems() {
    return widget.items.map(
      (T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(widget.displayStringForItem(item)),
        );
      },
    ).toList();
  }

  void _onChange(T? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }
}
