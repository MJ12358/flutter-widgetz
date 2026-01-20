part of flutter_widgetz;

/// {@template flutter_widgetz.DropdownField}
/// Uses an [InputDecorator] to show a bottom sheet.
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
    this.labelText = '',
    this.prefixIcon,
    this.suffixIcon = const Icon(Icons.arrow_drop_down),
    this.value,
  });

  /// The list of items the user can select.
  final Iterable<T> items;

  /// Called when the user selects an item.
  final ValueChanged<T> onChanged;

  /// The string that is displayed for each item.
  final String Function(T) displayStringForItem;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// An icon that appears after the editable part of the text field.
  final Widget? suffixIcon;

  /// The value of the currently selected item.
  final T? value;

  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T extends Object> extends State<DropdownField<T>> {
  late final FocusNode _focusNode;
  T? _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(DropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // workround: i dont know why the oldWidget.value is null here
    if (oldWidget.value != null) {
      _value = widget.value;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: widget.labelText,
      child: InkWell(
        focusNode: _focusNode,
        onFocusChange: _onFocusChange,
        onTap: _onTap,
        child: InputDecorator(
          isFocused: _focusNode.hasFocus,
          decoration: InputDecoration(
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
          ),
          child: Text(
            _value != null ? widget.displayStringForItem(_value!) : '',
          ),
        ),
      ),
    );
  }

  void _onTap() {
    showModalBottomSheet<T>(
      context: context,
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: _getItems(),
          ),
        );
      },
    ).then(_onChange);
  }

  List<Widget> _getItems() {
    return widget.items.map(
      (T item) {
        return ListTile(
          title: Text(widget.displayStringForItem(item)),
          onTap: () => Navigator.of(context).pop(item),
        );
      },
    ).toList();
  }

  void _onChange(T? value) {
    _onFocusChange(true);
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }

  void _onFocusChange(bool value) {
    if (value) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
    setState(() {});
  }
}
