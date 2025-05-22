part of flutter_widgetz;

/// {@template flutter_widgetz.CustomText}
/// This is meant to mimic the [CustomTextField] but without the input.
/// Shows a suffix icon with dialog alongside some [text].
/// {@endtemplate}.
class CustomText extends StatelessWidget {
  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The widget to be placed within the help dialog.
  final Widget help;

  /// An optional label for the dialog.
  final String? labelText;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// The style to use for the text.
  final TextStyle? style;

  /// The text to display.
  final String text;

  /// {@macro flutter_widgetz.CustomText}
  const CustomText.help(
    this.text, {
    super.key,
    required this.help,
    this.labelText,
    this.crossAxisAlignment = _defaultCrossAxisAlignment,
    this.mainAxisAlignment = _defaultMainAxisAlignment,
    this.style,
  });

  static const CrossAxisAlignment _defaultCrossAxisAlignment =
      CrossAxisAlignment.center;
  static const MainAxisAlignment _defaultMainAxisAlignment =
      MainAxisAlignment.spaceBetween;

  /// This is copied from [InputDecorationTheme].
  Color _getIconColor(ThemeData theme) {
    switch (theme.brightness) {
      case Brightness.dark:
        return Colors.white70;
      case Brightness.light:
        return Colors.black45;
    }
  }

  Widget _getHelp(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ExcludeFocus(
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) {
            return CustomDialog(
              title: labelText != null ? Text(labelText!) : const SizedBox(),
              contentPadding: const EdgeInsets.all(16.0),
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                child: help,
              ),
            );
          },
        ),
        child: Icon(
          Icons.info,
          color: _getIconColor(theme),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Text(text, style: style),
        const SizedBox(width: 8.0),
        _getHelp(context),
      ],
    );
  }
}
