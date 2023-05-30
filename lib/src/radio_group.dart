part of flutter_widgetz;

/// {@template flutter_widgetz.RadioGroup}
/// Wraps a list of [RadioListTile] in an [InputDecorator].
/// {@endtemplate}
class RadioGroup<T extends Object> extends StatefulWidget {
  /// {@macro flutter_widgetz.RadioGroup}
  const RadioGroup({
    super.key,
    required this.items,
    required this.onChanged,
    this.border = InputBorder.none,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.displayStringForItem = _defaultStringForItem,
    this.initialValue,
    this.labelText,
    this.prefixIcon,
  });

  /// The list of items the user can select.
  final Iterable<T> items;

  /// Called when the user selects an item.
  final ValueChanged<T> onChanged;

  /// The shape of the border to draw around the decoration's container.
  final InputBorder border;

  /// Where to place the control relative to the text.
  final ListTileControlAffinity controlAffinity;

  /// The string that is displayed for each item.
  final String Function(T) displayStringForItem;

  /// The initial value of the items.
  final T? initialValue;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final IconData? prefixIcon;

  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T extends Object> extends State<RadioGroup<T>> {
  late FocusNode _focusNode;
  T? _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.initialValue;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: _onFocusChange,
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          border: widget.border,
          labelText: widget.labelText,
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getChildren(),
        ),
      ),
    );
  }

  List<Widget> _getChildren() {
    return widget.items.map((T e) {
      return RadioListTile<T>(
        controlAffinity: widget.controlAffinity,
        groupValue: _value,
        onChanged: _onTap,
        title: Text(widget.displayStringForItem(e)),
        value: e,
      );
    }).toList();
  }

  void _onTap(T? value) {
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
