part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDialog}
/// A predictable dialog.
/// {@endtemplate}
class CustomDialog extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDialog}
  const CustomDialog({
    super.key,
    required this.child,
    this.contentPadding = _defaultContentPadding,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The padding of the content.
  final EdgeInsets contentPadding;

  /// The title of this dialog.
  final Widget? title;

  /// The padding of the title.
  final EdgeInsets titlePadding;

  static const EdgeInsets _defaultTitlePadding = EdgeInsets.all(20.0);
  static const EdgeInsets _defaultContentPadding = EdgeInsets.zero;

  /// {@macro flutter_widgetz.CustomDialog}
  ///
  /// Checkbox uses a [ListView] with [CheckboxListTile]s.
  CustomDialog.checkbox({
    super.key,
    required List<Enum> initialValues,
    required List<Enum> currentValues,
    required ValueChanged<Enum?> onChanged,
    String Function(Enum)? displayStringForValue,
    this.contentPadding = _defaultContentPadding,
    ScrollPhysics physics = const RangeMaintainingScrollPhysics(),
    bool shrinkWrap = true,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  }) : child = ListView(
          physics: physics,
          shrinkWrap: shrinkWrap,
          children: <Widget>[
            ...initialValues.map((Enum e) {
              return CheckboxListTile(
                title: Text(displayStringForValue?.call(e) ?? e.name),
                value: currentValues.contains(e),
                onChanged: (_) => onChanged.call(e),
              );
            }),
          ],
        );

  /// {@macro flutter_widgetz.CustomDialog}
  ///
  /// Radio uses a [ListView] with [RadioListTile]s.
  CustomDialog.radio({
    super.key,
    required List<Enum> values,
    required Enum groupValue,
    required ValueChanged<Enum?> onChanged,
    String Function(Enum)? displayStringForValue,
    this.contentPadding = _defaultContentPadding,
    ScrollPhysics physics = const RangeMaintainingScrollPhysics(),
    bool shrinkWrap = true,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  }) : child = ListView(
          physics: physics,
          shrinkWrap: shrinkWrap,
          children: <Widget>[
            ...values.map((Enum e) {
              return RadioListTile<Enum>(
                title: Text(displayStringForValue?.call(e) ?? e.name),
                value: e,
                groupValue: groupValue,
                onChanged: onChanged,
              );
            }),
          ],
        );

  /// {@macro flutter_widgetz.CustomDialog}
  ///
  /// List uses a list of widgets inside a [ListView].
  CustomDialog.list({
    super.key,
    required List<Widget> children,
    this.contentPadding = _defaultContentPadding,
    ScrollPhysics physics = const RangeMaintainingScrollPhysics(),
    bool shrinkWrap = true,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  }) : child = ListView(
          physics: physics,
          shrinkWrap: shrinkWrap,
          children: children,
        );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: contentPadding,
      titlePadding: EdgeInsets.zero,
      title: title != null
          ? _Title(
              padding: titlePadding,
              child: title!,
            )
          : null,
      content: SizedBox(
        // this is necessary to prevent render box issues in dialog
        width: double.minPositive,
        child: child,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary.blackOrWhite,
      ),
      child: Container(
        color: theme.colorScheme.primary,
        padding: padding,
        child: child,
      ),
    );
  }
}
