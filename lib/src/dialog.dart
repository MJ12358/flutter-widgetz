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

  static const double _defaultPadding = 20.0;
  static const EdgeInsets _defaultTitlePadding =
      EdgeInsets.all(_defaultPadding);
  static const EdgeInsets _defaultContentPadding = EdgeInsets.zero;

  /// {@macro flutter_widgetz.CustomDialog}
  ///
  /// Alert mimics the default alert dialog.
  CustomDialog.alert({
    super.key,
    required this.child,
    required BuildContext context,
    String acceptText = 'Accept',
    String cancelText = 'Cancel',
    this.contentPadding = const EdgeInsets.only(
      top: _defaultPadding,
      left: _defaultPadding,
      right: _defaultPadding,
    ),
    this.title,
    this.titlePadding = _defaultTitlePadding,
    VoidCallback? onAccept,
    VoidCallback? onCancel,
  }) : actions = <Widget>[
          TextButton(
            onPressed: () => onCancel != null
                ? onCancel.call()
                : Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => onAccept != null
                ? onAccept.call()
                : Navigator.of(context).pop(true),
            child: Text(acceptText),
          ),
        ];

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
              return RadioGroup<T>(
                groupValue: groupValue,
                onChanged: onChanged,
                child: RadioListTile<T>(
                  title: Text(displayStringForValue?.call(e) ?? e.toString()),
                  value: e,
                ),
              );
            }),
          ],
        );

  /// {@macro flutter_widgetz.CustomDialog}
  ///
  /// Simple mimics the default simple dialog.
  CustomDialog.simple({
    super.key,
    required Widget child,
    this.contentPadding = const EdgeInsets.all(_defaultPadding),
    this.title,
    this.titlePadding = _defaultTitlePadding,
  })  : actions = null,
        child = DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          // this is necessary to prevent dialog height from being full screen
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              child,
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: 'dialog',
      child: AlertDialog(
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
