part of flutter_widgetz;

/// {@template flutter_widgetz.CustomTextField}
/// A [TextFormField] with a single [TextInputFormatter].
/// Utilizing [hasError] to show [errorText].
/// {@endtemplate}
class CustomTextField extends StatelessWidget {
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
    this.helpText,
    this.hintText,
    this.initialValue,
    this.inputFormatter,
    this.keyboardType,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
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

  /// If given, shows a suffix icon and dialog with this string.
  final String? helpText;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// The initial value of this input.
  final String? initialValue;

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
  final IconData? prefixIcon;

  /// Configures padding when the input scrolls into view.
  final EdgeInsets scrollPadding;

  /// An icon that appers after the editable part of the text field.
  final Widget? suffixIcon;

  /// Determines whether to show an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// An action the user has requested the text input control to perform.
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      autofillHints: autofillHint != null ? <String>[autofillHint!] : null,
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      inputFormatters:
          inputFormatter != null ? <TextInputFormatter>[inputFormatter!] : null,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText,
      scrollPadding: scrollPadding,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        errorText: hasError ? errorText : null,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: _getSuffixIcon(context),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete ?? () => _onFocus(context),
    );
  }

  Widget? _getSuffixIcon(BuildContext context) {
    if (suffixIcon != null) {
      return suffixIcon;
    }
    if (helpText == null) {
      return null;
    }
    return ExcludeFocus(
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) {
            return SimpleDialog(
              title: labelText != null ? Text(labelText!) : const SizedBox(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: help ??
                      Text(
                        helpText!,
                        textAlign: TextAlign.center,
                      ),
                ),
              ],
            );
          },
        ),
        child: const Icon(Icons.info),
      ),
    );
  }

  void _onFocus(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);
    switch (textInputAction) {
      case TextInputAction.next:
        node.nextFocus();
      case TextInputAction.previous:
        node.previousFocus();
      default:
        node.unfocus();
        return;
    }
  }
}
