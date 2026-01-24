part of flutter_widgetz;

/// {@template flutter_widgetz.Card}
/// A customizable card widget.
///
/// ![Card](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/card.png)
/// {@endtemplate}
class CustomCard extends StatelessWidget {
  /// The content of the card.
  final Widget child;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// The padding inside the card.
  final EdgeInsetsGeometry padding;

  /// The border radius of the card and title.
  final Radius radius;

  /// The title displayed above the card.
  final Widget title;

  /// The padding around the title.
  final EdgeInsetsGeometry titlePadding;

  static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.all(8.0);
  static const Radius _defaultRadius = Radius.circular(8.0);
  static const EdgeInsetsGeometry _defaultTitlePadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  /// Titled adds a title above the card.
  ///
  /// {@macro flutter_widgetz.Card}
  const CustomCard.titled({
    super.key,
    required this.child,
    required this.title,
    this.onTap,
    this.padding = _defaultPadding,
    this.radius = _defaultRadius,
    this.titlePadding = _defaultTitlePadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _CardTitle(
          radius: radius,
          title: title,
          titlePadding: titlePadding,
        ),
        _CardContent(
          onTap: onTap,
          padding: padding,
          radius: radius,
          child: child,
        ),
      ],
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    required this.radius,
    required this.title,
    required this.titlePadding,
  });

  final Radius radius;
  final Widget title;
  final EdgeInsetsGeometry titlePadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: titlePadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
      ),
      child: DefaultTextStyle(
        style: theme.textTheme.labelLarge!.copyWith(
          color: theme.colorScheme.primary.blackOrWhite,
          fontWeight: FontWeight.bold,
        ),
        child: title,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.child,
    required this.onTap,
    required this.padding,
    required this.radius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Radius radius;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
