part of flutter_widgetz;

/// {@template flutter_widgetz.CustomTabBar}
/// A [TabBar] that automatically unfocuses on tap.
/// {@endtemplate}
class CustomTabBar extends TabBar {
  /// {@macro flutter_widgetz.CustomTabBar}
  CustomTabBar({
    super.key,
    required super.tabs,
    super.controller,
    ValueChanged<int>? onTap,
    super.isScrollable,
    super.padding,
    super.physics,
    super.splashFactory,
    super.tabAlignment,
  }) : super(
          onTap: (int i) {
            onTap?.call(i);
            FocusManager.instance.primaryFocus?.unfocus();
          },
        );
}
