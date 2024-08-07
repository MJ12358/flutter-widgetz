part of flutter_widgetz;

/// {@template flutter_widgetz.CheckboxGroup}
/// Wraps a list of [CheckboxListTile] in an [InputDecorator].
///
///![CheckboxGroup](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/checkbox_group.png)
/// {@endtemplate}
class CheckboxGroup<T extends Object> extends StatefulWidget {
  /// {@macro flutter_widgetz.CheckboxGroup}
  const CheckboxGroup({
    super.key,
    required this.items,
    required this.onChanged,
    this.border = InputBorder.none,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.displayStringForItem = _defaultStringForItem,
    this.initialValues,
    this.labelText,
    this.prefixIcon,
  });

  /// The list of items the user can select.
  final Iterable<T> items;

  /// Called when the user selects an item.
  final ValueChanged<List<T>> onChanged;

  /// The shape of the border to draw around the decoration's container.
  final InputBorder border;

  /// Where to place the control relative to the text.
  final ListTileControlAffinity controlAffinity;

  /// The string that is displayed for each item.
  final String Function(T) displayStringForItem;

  /// The initial values of the items.
  final Iterable<T>? initialValues;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  @override
  State<CheckboxGroup<T>> createState() => _CheckboxGroupState<T>();
}

class _CheckboxGroupState<T extends Object> extends State<CheckboxGroup<T>> {
  late final FocusNode _focusNode;
  late List<T> _values;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _values = widget.initialValues?.toList() ?? <T>[];
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
          prefixIcon: widget.prefixIcon,
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
      return CheckboxListTile(
        controlAffinity: widget.controlAffinity,
        onChanged: (_) => _onTap(e),
        title: Text(widget.displayStringForItem(e)),
        value: _values.contains(e),
      );
    }).toList();
  }

  void _onTap(T item) {
    _onFocusChange(true);
    if (_values.contains(item)) {
      _values.remove(item);
    } else {
      _values.add(item);
    }
    setState(() {
      _values = _values;
    });
    widget.onChanged(_values);
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
