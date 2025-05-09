part of flutter_widgetz;

/// {@template flutter_widgetz.CustomDialog}
/// A predictable dialog.
///
///![CustomDialog](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/dialog.png)
/// {@endtemplate}
@optionalTypeArgs
class CustomDialog<T> extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomDialog}
  const CustomDialog({
    super.key,
    required this.child,
    this.actions,
    this.contentPadding = _defaultContentPadding,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The (optional) set of actions that are displayed at the bottom
  /// of the dialog with an [OverflowBar].
  final List<Widget>? actions;

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
    required List<T> initialValues,
    required List<T> currentValues,
    required ValueChanged<T?> onChanged,
    this.actions,
    String Function(T)? displayStringForValue,
    this.contentPadding = _defaultContentPadding,
    ScrollPhysics physics = const RangeMaintainingScrollPhysics(),
    bool shrinkWrap = true,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  }) : child = ListView(
          physics: physics,
          shrinkWrap: shrinkWrap,
          children: <Widget>[
            ...initialValues.map((T e) {
              return CheckboxListTile(
                title: Text(displayStringForValue?.call(e) ?? e.toString()),
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
    required List<T> values,
    required T groupValue,
    required ValueChanged<T?> onChanged,
    this.actions,
    String Function(T)? displayStringForValue,
    this.contentPadding = _defaultContentPadding,
    ScrollPhysics physics = const RangeMaintainingScrollPhysics(),
    bool shrinkWrap = true,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  }) : child = ListView(
          physics: physics,
          shrinkWrap: shrinkWrap,
          children: <Widget>[
            ...values.map((T e) {
              return RadioListTile<T>(
                title: Text(displayStringForValue?.call(e) ?? e.toString()),
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
    this.actions,
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

  /// {@macro flutter_widgetz.CustomDialog}
  ///
  /// Alert mimics the default alert dialog.
  CustomDialog.alert({
    super.key,
    required this.child,
    required BuildContext context,
    String acceptText = 'Accept',
    String cancelText = 'Cancel',
    EdgeInsets? contentPadding,
    this.title,
    this.titlePadding = _defaultTitlePadding,
  })  : actions = <Widget>[
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(acceptText),
          ),
        ],
        contentPadding = contentPadding ??
            const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
            );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: actions,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: title != null
          ? _Title(
              padding: titlePadding,
              child: title!,
            )
          : null,
      content: Container(
        padding: contentPadding,
        // this is necessary to prevent render box issues
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            // this is to mimic the default alert dialog border radius
            top: Radius.circular(4.0),
          ),
          color: theme.colorScheme.primary,
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
