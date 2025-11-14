part of flutter_widgetz;

/// {@template flutter_widgetz.CustomTextField}
/// A [TextFormField] with a single [TextInputFormatter].
/// Utilizing [hasError] to show [errorText].
/// {@endtemplate}
class CustomTextField extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomTextField}
  const CustomTextField({
    super.key,
    this.autofillHint,
    this.autofocus = false,
    this.controller,
    this.errorText,
    this.focusNode,
    this.hasError = false,
    this.help,
    this.hintText,
    this.inputFormatter,
    this.keyboardType,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.restorationId,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.style,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.value,
  });

  /// Determines what the input field expects.
  final String? autofillHint;

  /// Determines whether to auto focus this input.
  final bool autofocus;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The text shown when there is an error.
  final String? errorText;

  /// Used to obtain the keyboard focus and to handle keyboard events.
  final FocusNode? focusNode;

  /// Determines if an error should be displayed.
  final bool hasError;

  /// If given, shows a suffix icon and dialog with this widget.
  final Widget? help;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Provides as-you-type validation and formatting of the text being edited.
  final TextInputFormatter? inputFormatter;

  /// The type of information for which to optimize the text input control.
  final TextInputType? keyboardType;

  /// An optional label for this input.
  final String? labelText;

  /// The maximum number of lines for this input.
  final int? maxLines;

  /// The minimum number of lines for this input.
  final int? minLines;

  /// Determines whether to obscure the text in this input.
  final bool obscureText;

  /// Called when the value of the input changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits editable content
  /// (e.g., user presses the "done" button on the keyboard).
  final VoidCallback? onEditingComplete;

  /// An icon that appers before the editable part of the text field.
  final Widget? prefixIcon;

  /// Restoration ID to save and restore the state of the form field.
  final String? restorationId;

  /// Configures padding when the input scrolls into view.
  final EdgeInsets scrollPadding;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// An icon that appers after the editable part of the text field.
  final Widget? suffixIcon;

  /// Determines whether to show an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// An action the user has requested the text input control to perform.
  final TextInputAction? textInputAction;

  /// The value of the input.
  final String? value;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.value = _textEditingValue;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.value = _textEditingValue;
    }
  }

  TextEditingValue get _textEditingValue {
    final String _value = widget.value ?? '';
    return TextEditingValue(
      text: _value,
      selection: TextSelection.collapsed(
        offset: _value.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: widget.labelText,
      child: TextFormField(
        autofocus: widget.autofocus,
        autofillHints:
            widget.autofillHint != null ? <String>[widget.autofillHint!] : null,
        controller: _controller,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatter != null
            ? <TextInputFormatter>[widget.inputFormatter!]
            : null,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        obscureText: widget.obscureText,
        restorationId: widget.restorationId,
        scrollPadding: widget.scrollPadding,
        style: widget.style,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          errorText: widget.hasError ? widget.errorText : null,
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: _getSuffixIcon(context),
        ),
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete ?? () => _onFocus(context),
      ),
    );
  }

  Widget? _getSuffixIcon(BuildContext context) {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    if (widget.help == null) {
      return null;
    }
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (_) {
          return CustomDialog.simple(
            title: widget.labelText != null ? Text(widget.labelText!) : null,
            child: widget.help!,
          );
        },
      ),
      child: const Icon(Icons.info),
    );
  }

  void _onFocus(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);
    switch (widget.textInputAction) {
      case TextInputAction.next:
        node.nextFocus();
      case TextInputAction.previous:
        node.previousFocus();
      case TextInputAction.newline:
        return;
      default:
        node.unfocus();
    }
  }
}
