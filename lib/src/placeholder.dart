part of flutter_widgetz;

/// {@template flutter_widgetz.CustomPlaceholder}
/// A placeholder that displays an image above some text.
/// {@endtemplate}
class CustomPlaceholder extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomPlaceholder}
  const CustomPlaceholder({
    super.key,
    this.text,
    this.child,
    this.mainAxisAlignment = _defaultAlignment,
    this.padding = _defaultPadding,
  });

  /// The text of this placeholder.
  final String? text;

  /// A widget to be used above the text.
  final Widget? child;

  /// How the children should be placed along the main axis in a flex layout.
  final MainAxisAlignment mainAxisAlignment;

  /// The padding around the [text].
  final EdgeInsets padding;

  static const MainAxisAlignment _defaultAlignment = MainAxisAlignment.center;
  static const EdgeInsets _defaultPadding = EdgeInsets.all(20.0);

  /// {@macro flutter_widgetz.CustomPlaceholder}
  ///
  /// Asset uses [Image.asset] as [child].
  CustomPlaceholder.asset(
    String name, {
    super.key,
    this.text,
    this.mainAxisAlignment = _defaultAlignment,
    this.padding = _defaultPadding,
  }) : child = Image.asset(name);

  /// {@macro flutter_widgetz.CustomPlaceholder}
  ///
  /// Network uses [Image.network] as [child].
  CustomPlaceholder.network(
    String source, {
    super.key,
    this.text,
    this.mainAxisAlignment = _defaultAlignment,
    this.padding = _defaultPadding,
  }) : child = Image.network(source);

  /// {@macro flutter_widgetz.CustomPlaceholder}
  ///
  /// Flashlight uses a "flashlight" image as [child].
  CustomPlaceholder.flashlight({
    super.key,
    this.text,
    this.mainAxisAlignment = _defaultAlignment,
    this.padding = _defaultPadding,
  }) : child = Image.asset(
          _kFlashlightImage,
          package: _kPackage,
        );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _getTheme(context),
      child: Center(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            _getChild(context),
            _getText(context),
          ],
        ),
      ),
    );
  }

  Widget _getChild(BuildContext context) {
    if (child == null) {
      return const SizedBox();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: child,
    );
  }

  Widget _getText(BuildContext context) {
    if (text == null) {
      return const SizedBox();
    }

    return Padding(
      padding: padding,
      child: Text(
        text!,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  ThemeData _getTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      iconTheme: theme.iconTheme.copyWith(
        color: theme.scaffoldBackgroundColor.blackOrWhite,
      ),
    );
  }
}
