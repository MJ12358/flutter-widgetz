part of flutter_widgetz;

/// {@template flutter_widgetz.CustomBadge}
/// A badge with convenience constructors.
/// {@endtemplate}
class CustomBadge extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomBadge}
  const CustomBadge({
    super.key,
    this.child,
    this.color = const Color(0xFFF3F3F3),
    this.label,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The badge's fill color.
  final Color? color;

  /// The badge's content.
  final Widget? label;

  /// {@macro flutter_widgetz.CustomBadge}
  ///
  /// Inverse uses a grey color.
  const CustomBadge.inverse({
    super.key,
    this.child,
    this.label,
  }) : color = const Color(0xFF747474);

  /// {@macro flutter_widgetz.CustomBadge}
  ///
  /// Lightest uses a white color.
  const CustomBadge.lightest({
    super.key,
    this.child,
    this.label,
  }) : color = const Color(0xFFFFFFFF);

  /// {@macro flutter_widgetz.CustomBadge}
  ///
  /// Success uses a green color.
  const CustomBadge.success({
    super.key,
    this.child,
    this.label,
  }) : color = const Color(0xFF2E844A);

  /// {@macro flutter_widgetz.CustomBadge}
  ///
  /// Warning uses an orange color.
  const CustomBadge.warning({
    super.key,
    this.child,
    this.label,
  }) : color = const Color(0xFFFE9339);

  /// {@macro flutter_widgetz.CustomBadge}
  ///
  /// Error uses a red color.
  const CustomBadge.error({
    super.key,
    this.child,
    this.label,
  }) : color = const Color(0xFFEA001E);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: Theme.of(context).iconTheme.copyWith(
            color: Theme.of(context).scaffoldBackgroundColor.blackOrWhite,
          ),
      child: Badge(
        backgroundColor: color,
        label: label,
        textColor: color?.blackOrWhite,
        child: child,
      ),
    );
  }
}
