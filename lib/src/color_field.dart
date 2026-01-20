part of flutter_widgetz;

/// {@template flutter_widgetz.ColorField}
/// Wraps a call to [showModalBottomSheet]->[ColorPicker]
/// in an [InputDecorator] and [InkWell].
///
///![ColorField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/color_field.png)
/// {@endtemplate}
class ColorField extends StatefulWidget {
  /// {@macro flutter_widgetz.ColorField}
  const ColorField({
    super.key,
    required this.modalBuilder,
    required this.onChanged,
    this.colors,
    this.displayStringForColor = _defaultStringForColor,
    this.labelText,
    this.pickerShape = _defaultPickerShape,
    this.pickerTitle,
    this.prefixIcon = _defaultIcon,
    this.value,
  });

  /// A list of Colors to display for selection.
  ///
  /// Defaults to [Colors.primaries].
  final List<Color>? colors;

  /// The string that is displayed in the input.
  final String Function(Color?) displayStringForColor;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The material modal builder.
  final Future<Color?> Function({
    required BuildContext context,
    required Widget widget,
  }) modalBuilder;

  /// Called whenever the value changes.
  final ValueChanged<Color> onChanged;

  /// The shape to fill the picker background.
  final BoxShape pickerShape;

  /// A title shown above the picker.
  final Widget? pickerTitle;

  /// An icon that appears before the editable part of the text field.
  final Widget prefixIcon;

  /// The value of this input.
  final Color? value;

  static const Widget _defaultIcon = Icon(Icons.color_lens);
  static const BoxShape _defaultPickerShape = BoxShape.circle;
  static String _defaultStringForColor(Color? color) =>
      color != null ? Color(color.toARGB32()).toString() : '';

  static Future<Color?> _showBottomSheet({
    required BuildContext context,
    required Widget widget,
  }) {
    return showModalBottomSheet<Color?>(
      context: context,
      builder: (_) {
        return SafeArea(child: widget);
      },
    );
  }

  static Future<Color?> _showDialog({
    required BuildContext context,
    required Widget widget,
  }) {
    return showDialog<Color?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: widget,
        );
      },
    );
  }

  /// {@macro flutter_widgetz.ColorField}
  ///
  /// BottomSheet uses [showModalBottomSheet].
  const ColorField.bottomSheet({
    super.key,
    required this.onChanged,
    this.colors,
    this.displayStringForColor = _defaultStringForColor,
    this.labelText,
    this.pickerShape = _defaultPickerShape,
    this.pickerTitle,
    this.prefixIcon = _defaultIcon,
    this.value,
  }) : modalBuilder = _showBottomSheet;

  /// {@macro flutter_widgetz.ColorField}
  ///
  /// Dialog uses [showDialog] with [AlertDialog].
  const ColorField.dialog({
    super.key,
    required this.onChanged,
    this.colors,
    this.displayStringForColor = _defaultStringForColor,
    this.labelText,
    this.pickerShape = _defaultPickerShape,
    this.pickerTitle,
    this.prefixIcon = _defaultIcon,
    this.value,
  }) : modalBuilder = _showDialog;

  @override
  State<ColorField> createState() => _ColorFieldState();
}

class _ColorFieldState extends State<ColorField> {
  late final FocusNode _focusNode;
  Color? _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(ColorField oldWidget) {
    super.didUpdateWidget(oldWidget);
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

    return Semantics(
      identifier: widget.labelText,
      child: InkWell(
        focusNode: _focusNode,
        onFocusChange: _onFocusChange,
        onTap: () => _showModal(context),
        child: InputDecorator(
          isFocused: _focusNode.hasFocus,
          decoration: InputDecoration(
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon,
          ),
          child: Text(
            widget.displayStringForColor(_value),
            style: theme.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    widget
        .modalBuilder(
          context: context,
          widget: ColorPicker(
            colors: widget.colors,
            decoration: BoxDecoration(
              border: Border.all(),
              shape: widget.pickerShape,
            ),
            initialColor: _value,
            title: widget.pickerTitle,
            onTap: _onChange,
          ),
        )
        .then(_onChange);
  }

  void _onChange(Color? value) {
    _onFocusChange(true);
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
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
