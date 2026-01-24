part of flutter_widgetz;

/// {@template flutter_widgetz.CheckboxField}
/// Wraps a [Checkbox] with an [InputDecorator] and [InkWell]
/// to provide a fully clickable input.
///
///![CheckboxField](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/checkbox_field.png)
/// {@endtemplate}
class CheckboxField extends StatefulWidget {
  /// {@macro flutter_widgetz.CheckboxField}
  const CheckboxField({
    super.key,
    required this.onChanged,
    required this.value,
    this.labelText,
  });

  /// Called when the value of the checkbox changed.
  final ValueChanged<bool> onChanged;

  /// Whether this checkbox is checked.
  final bool value;

  /// Optional text that describes the input field.
  final String? labelText;

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  late final FocusNode _focusNode;
  late bool _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(CheckboxField oldWidget) {
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
        onTap: _onInputTap,
        child: InputDecorator(
          isEmpty: true,
          isFocused: _focusNode.hasFocus,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Checkbox(
              value: _value,
              onChanged: _onCheckboxTap,
            ),
          ),
          child: Text(
            widget.labelText ?? '',
            style: theme.textTheme.titleMedium?.copyWith(
              color: _focusNode.hasFocus
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }

  void _onCheckboxTap(bool? value) {
    _onFocusChange(true);
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  void _onInputTap() {
    _onFocusChange(true);
    setState(() {
      _value = !_value;
    });
    widget.onChanged(_value);
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
