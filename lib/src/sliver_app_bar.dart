part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSliverAppBar}
/// A [SliverAppBar] with an `onPinned` callback.
/// {@endtemplate}
class CustomSliverAppBar extends SliverAppBar {
  /// {@macro flutter_widgetz.CustomSliverAppBar}
  CustomSliverAppBar({
    super.key,
    required Widget child,
    VoidCallback? onPinned,
    super.actions,
    super.automaticallyImplyLeading,
    super.bottom,
    super.expandedHeight,
    super.leading,
    super.pinned,
  }) : super(
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final MediaQueryData mediaQuery = MediaQuery.of(context);
              final double top = constraints.biggest.height;
              final double height = mediaQuery.padding.top + kToolbarHeight;
              final bool isPinned = top == height;
              if (isPinned) {
                onPinned?.call();
              }
              return child;
            },
          ),
        );
}
