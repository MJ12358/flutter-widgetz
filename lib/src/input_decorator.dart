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
    this.help,
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

  /// If given, shows a suffix icon and dialog with this widget.
  final Widget? help;

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

    return Semantics(
      identifier: labelText,
      child: InputDecorator(
        isFocused: isFocused,
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          errorText: errorText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: _getSuffixIcon(context),
        ),
        child: DefaultTextStyle.merge(
          style: theme.textTheme.titleMedium,
          child: child,
        ),
      ),
    );
  }

  Widget? _getSuffixIcon(BuildContext context) {
    if (suffixIcon != null) {
      return suffixIcon;
    }
    if (help == null) {
      return null;
    }
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (_) {
          return CustomDialog.simple(
            title: labelText != null ? Text(labelText!) : null,
            child: help!,
          );
        },
      ).then((_) {
        // Unfocus any input when exiting the help dialog
        if (context.mounted) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }),
      child: const Icon(Icons.info),
    );
  }
}
