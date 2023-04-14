part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSingleChildScrollView}
/// Wraps a [SingleChildScrollView] in a
/// [LayoutBuilder] in order to allow the full
/// height of the screen via a [ConstrainedBox].
/// {@endtemplate}
class CustomSingleChildScrollView extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomSingleChildScrollView}
  const CustomSingleChildScrollView({
    Key? key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.physics,
  }) : super(key: key);

  /// The [child] contained by the container.
  final Widget child;

  /// Empty space to wrap the [child].
  final EdgeInsets padding;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: physics,
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minHeight: constraints.maxHeight,
              maxHeight: double.infinity,
            ),
            child: Container(
              padding: padding,
              width: double.infinity,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
