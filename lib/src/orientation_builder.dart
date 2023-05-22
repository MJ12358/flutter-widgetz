part of flutter_widgetz;

/// {@template flutter_widgetz.CustomOrientationBuilder}
/// Wraps an [OrientationBuilder] that automatically
/// determines the orientation and calls the appropriate builder.
/// {@endtemplate}
class CustomOrientationBuilder extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomOrientationBuilder}
  const CustomOrientationBuilder({
    super.key,
    required this.landscapeBuilder,
    required this.portraitBuilder,
    this.onDispose,
  });

  /// Builds a widget to be used in [Orientation.landscape].
  final WidgetBuilder landscapeBuilder;

  /// Builds a widget to be used in [Orientation.portrait].
  final WidgetBuilder portraitBuilder;

  /// Called when this widget is disposed of.
  final void Function()? onDispose;

  static void _resetOnDispose() {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[]);
  }

  /// {@macro flutter_widgetz.CustomOrientationBuilder}
  ///
  /// Forces [Orientation.landscape].
  CustomOrientationBuilder.landscape({
    super.key,
    required WidgetBuilder builder,
  })  : landscapeBuilder = builder,
        portraitBuilder = builder,
        onDispose = _resetOnDispose {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// {@macro flutter_widgetz.CustomOrientationBuilder}
  ///
  /// Forces [Orientation.portrait].
  CustomOrientationBuilder.portrait({
    super.key,
    required WidgetBuilder builder,
  })  : landscapeBuilder = builder,
        portraitBuilder = builder,
        onDispose = _resetOnDispose {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  State<CustomOrientationBuilder> createState() =>
      _CustomOrientationBuilderState();
}

class _CustomOrientationBuilderState extends State<CustomOrientationBuilder> {
  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, _) {
        switch (MediaQuery.of(context).orientation) {
          case Orientation.landscape:
            return widget.landscapeBuilder(context);
          case Orientation.portrait:
            return widget.portraitBuilder(context);
        }
      },
    );
  }
}
