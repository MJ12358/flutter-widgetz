part of flutter_widgetz;

/// {@template flutter_widgetz.CustomInputDecorator}
/// A simple wrapper around an [InputDecorator].
/// {@endtemplate}
class CustomInputDecorator extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomInputDecorator}
  const CustomInputDecorator({
    super.key,
    required this.child,
    this.border,
    this.errorText,
    this.isFocused = false,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The shape of the border to draw around the decoration's container.
  final InputBorder? border;

  /// Text that appears below the [child].
  final String? errorText;

  /// Whether the input field has focus.
  final bool isFocused;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears after the input field.
  final Widget? suffixIcon;

  /// An icon that appears before the input field.
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InputDecorator(
      isFocused: isFocused,
      decoration: InputDecoration(
        border: border,
        errorText: errorText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.titleMedium,
        child: child,
      ),
    );
  }
}
