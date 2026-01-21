part of flutter_widgetz;

enum _DropdownModalType {
  bottomSheet,
  dialog,
}

/// {@template flutter_widgetz.DropdownField}
///
///![DropdownField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/dropdown_field1.png)
///
///![DropdownField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/dropdown_field2.png)
/// {@endtemplate}
class DropdownField<T extends Object> extends StatefulWidget {
  /// The list of items the user can select.
  final List<T> items;

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

  /// The type of modal to display.
  final _DropdownModalType _modalType;

  static const Widget _defaultSuffixIcon = Icon(Icons.arrow_drop_down);
  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  /// Creates a [DropdownField] that shows a bottom sheet.
  ///
  /// {@macro flutter_widgetz.DropdownField}
  const DropdownField.bottomSheet({
    super.key,
    required this.items,
    required this.onChanged,
    this.displayStringForItem = _defaultStringForItem,
    this.labelText = '',
    this.prefixIcon,
    this.suffixIcon = _defaultSuffixIcon,
    this.value,
  }) : _modalType = _DropdownModalType.bottomSheet;

  /// Creates a [DropdownField] that shows a dialog.
  ///
  /// {@macro flutter_widgetz.DropdownField}
  const DropdownField.dialog({
    super.key,
    required this.items,
    required this.onChanged,
    this.displayStringForItem = _defaultStringForItem,
    this.labelText = '',
    this.prefixIcon,
    this.suffixIcon = _defaultSuffixIcon,
    this.value,
  }) : _modalType = _DropdownModalType.dialog;

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
    final ThemeData theme = Theme.of(context);

    return Semantics(
      identifier: widget.labelText,
      child: InkWell(
        focusNode: _focusNode,
        onFocusChange: _onFocusChange,
        onTap: _onTap,
        child: InputDecorator(
          isEmpty: _value == null,
          isFocused: _focusNode.hasFocus,
          decoration: InputDecoration(
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
          ),
          child: Text(
            _value != null ? widget.displayStringForItem(_value!) : '',
            style: theme.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  void _onTap() {
    switch (widget._modalType) {
      case _DropdownModalType.bottomSheet:
        _showBottomSheet();
      case _DropdownModalType.dialog:
        _showDialog();
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet<T>(
      context: context,
      builder: (_) {
        return _DropdownList<T>(
          items: widget.items,
          displayStringForItem: widget.displayStringForItem,
        );
      },
    ).then(_onChange);
  }

  void _showDialog() {
    showDialog<T>(
      context: context,
      builder: (_) {
        return Dialog(
          child: _DropdownList<T>(
            items: widget.items,
            displayStringForItem: widget.displayStringForItem,
          ),
        );
      },
    ).then(_onChange);
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

class _DropdownList<T extends Object> extends StatelessWidget {
  const _DropdownList({
    required this.items,
    required this.displayStringForItem,
  });

  final List<T> items;
  final String Function(T) displayStringForItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (_, int index) {
          return _DropdownTile<T>(
            item: items[index],
            displayStringForItem: displayStringForItem,
          );
        },
        separatorBuilder: (_, __) {
          return const Divider();
        },
      ),
    );
  }
}

class _DropdownTile<T extends Object> extends StatelessWidget {
  const _DropdownTile({
    required this.item,
    required this.displayStringForItem,
  });

  final T item;
  final String Function(T) displayStringForItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(displayStringForItem(item)),
      onTap: () => Navigator.of(context).pop(item),
    );
  }
}
