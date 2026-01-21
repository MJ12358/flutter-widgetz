part of flutter_widgetz;

/// {@template flutter_widgetz.CustomAppBar}
/// An [AppBar] with conveniences.
///
///![CustomAppBar](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/app_bar.png)
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

  /// Subtitled also requires a [subtitle] and places
  /// the [title] and [subtitle] in a column.
  ///
  /// {@macro flutter_widgetz.CustomAppBar}
  CustomAppBar.subtitled({
    super.key,
    super.actions,
    super.automaticallyImplyLeading,
    super.backgroundColor,
    super.bottom,
    super.centerTitle = _defaultCenterTitle,
    super.leading,
    required Widget? subtitle,
    required Widget title,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    TextAlign textAlign = TextAlign.left,
  }) : super(
          title: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: <Widget>[
              DefaultTextStyle.merge(
                textAlign: textAlign,
                child: title,
              ),
              if (subtitle != null)
                DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 10),
                  textAlign: textAlign,
                  child: subtitle,
                ),
            ],
          ),
        );
}
