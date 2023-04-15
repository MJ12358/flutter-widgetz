part of flutter_widgetz;

/// {@template flutter_widgetz.DropdownInput}
/// Wraps a [DropdownButton] in an [InputDecorator].
/// {@endtemplate}
class DropdownInput<T extends Object> extends StatefulWidget {
  /// {@macro flutter_widgetz.DropdownInput}
  const DropdownInput({
    Key? key,
    required this.items,
    required this.onChanged,
    this.displayStringForItem = _defaultStringForItem,
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
  final String Function(T) displayStringForItem;

  /// Optional text that describes the input field.
  final String? labelText;

  /// Reduce the widgets height.
  final bool isDense;

  /// An icon that appears before the editable part of the text field.
  final IconData? prefixIcon;

  /// The value of the currently selected [DropdownMenuItem].
  final T? value;

  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  @override
  State<DropdownInput<T>> createState() => _DropdownInputState<T>();
}

class _DropdownInputState<T extends Object> extends State<DropdownInput<T>> {
  late T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: _value,
          isDense: widget.isDense,
          onChanged: _handleChange,
          items: _getItems(),
        ),
      ),
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

  void _handleChange(T? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }
}
