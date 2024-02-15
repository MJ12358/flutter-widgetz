part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAppBar}
/// An [AppBar] with conveniences.
/// {@endtemplate}
class CustomAppBar extends AppBar {
  /// {@macro flutter_widgetz.CustomAppBar}
  CustomAppBar({
    super.key,
    super.actions,
    super.automaticallyImplyLeading,
    super.backgroundColor,
    super.bottom,
    super.centerTitle = _defaultCenterTitle,
    super.leading,
    super.title,
  });

  static const bool _defaultCenterTitle = false;

  /// {@macro flutter_widgetz.CustomAppBar}
  ///
  /// Subtitled also requires a [subtitle] and places
  /// the [title] and [subtitle] in a column.
  CustomAppBar.subtitled({
    super.key,
    super.actions,
    super.automaticallyImplyLeading,
    super.backgroundColor,
    super.bottom,
    super.centerTitle = _defaultCenterTitle,
    super.leading,
    required Widget subtitle,
    required Widget title,
  }) : super(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DefaultTextStyle.merge(
                textAlign: TextAlign.left,
                child: title,
              ),
              DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.left,
                child: subtitle,
              ),
            ],
          ),
        );
}
