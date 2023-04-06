part of flutter_widgetz;

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.autofocus = false,
    this.controller,
    this.errorText,
    this.focusNode,
    this.helpText,
    this.initialValue,
    this.inputFormatter,
    this.keyboardType,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    this.prefixIcon,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.showError = false,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onChanged,
  }) : super(key: key);

  final bool autofocus;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final String? helpText;
  final String? initialValue;
  final TextInputFormatter? inputFormatter;
  final TextInputType? keyboardType;
  final String? labelText;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final IconData? prefixIcon;
  final EdgeInsets scrollPadding;
  final bool showError;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
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
        errorText: showError ? errorText : null,
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: _getSuffixIcon(context),
      ),
      onChanged: onChanged,
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
                  child: Text(
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
}
