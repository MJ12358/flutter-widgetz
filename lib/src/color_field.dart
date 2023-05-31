part of flutter_widgetz;

/// {@template flutter_widgetz.ColorField}
/// Wraps a call to [showModalBottomSheet]->[ColorPicker]
/// in an [InputDecorator] and [InkWell].
/// {@endtemplate}
class ColorField extends StatefulWidget {
  /// {@macro flutter_widgetz.ColorField}
  const ColorField({
    super.key,
    this.colors,
    this.displayStringForColor = _defaultStringForColor,
    this.labelText = 'Color',
    this.onChanged,
    this.pickerShape,
    this.pickerTitle,
    this.prefixIcon = Icons.color_lens,
    this.value,
  });

  /// A list of Colors to display for selection.
  ///
  /// Defaults to [Colors.primaries].
  final List<Color>? colors;

  /// The string that is displayed in the input.
  final String Function(Color?) displayStringForColor;

  /// Optional text that describes the input field.
  final String labelText;

  /// Called whenever the value changes.
  final ValueChanged<Color>? onChanged;

  /// The shape to fill the picker background.
  final BoxShape? pickerShape;

  /// A title shown above the picker.
  final String? pickerTitle;

  /// An icon that appears before the editable part of the text field.
  final IconData prefixIcon;

  /// The value of this input.
  final Color? value;

  static String _defaultStringForColor(Color? color) {
    return color?.toString() ?? '';
  }

  @override
  State<ColorField> createState() => _ColorFieldState();
}

class _ColorFieldState extends State<ColorField> {
  late FocusNode _focusNode;
  Color? _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      focusNode: _focusNode,
      onFocusChange: _onFocusChange,
      onTap: () => _showModal(context),
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.prefixIcon),
        ),
        child: Text(
          widget.displayStringForColor(_value),
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet<Color?>(
      context: context,
      builder: (BuildContext context) {
        return ColorPicker(
          colors: widget.colors,
          initialColor: _value,
          shape: widget.pickerShape,
          title: widget.pickerTitle,
          onTap: _onChange,
        );
      },
    ).then(_onChange);
  }

  void _onChange(Color? value) {
    _onFocusChange(true);
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(value);
    Navigator.of(context).pop();
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
