part of flutter_widgetz;

/// {@template flutter_widgetz.CustomInputDecorator}
/// A simple wrapper around an [InputDecorator].
/// {@endtemplate}
class CustomInputDecorator extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomInputDecorator}
  const CustomInputDecorator({
    super.key,
    this.border,
    this.child,
    this.errorText,
    this.isFocused = false,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.text = '',
  }) : assert(
          child != null || text.length > 0,
          'Either child or text must be specified.',
        );

  /// The shape of the border to draw around the decoration's container.
  final InputBorder? border;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Text that appears below the [child].
  final String? errorText;

  /// Whether the input field has focus.
  final bool isFocused;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears after the input field.
  final IconData? suffixIcon;

  /// An icon that appears before the input field.
  final IconData? prefixIcon;

  /// Text used if [child] is null.
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InputDecorator(
      isFocused: isFocused,
      decoration: InputDecoration(
        border: border,
        errorText: errorText,
        labelText: labelText,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      child: child ??
          Text(
            text,
            style: theme.textTheme.titleMedium,
          ),
    );
  }
}
