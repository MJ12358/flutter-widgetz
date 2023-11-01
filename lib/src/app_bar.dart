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
    super.bottom,
    bool centerTitle = _defaultCenterTitle,
    super.leading,
    Widget? title,
    String? titleText,
  })  : assert(
          title != null || titleText != null,
          'One of title or titleText must be supplied.',
        ),
        super(
          centerTitle: centerTitle,
          title: title ?? Text(titleText!),
        );

  static const bool _defaultCenterTitle = false;

  /// {@macro flutter_widgetz.CustomAppBar}
  ///
  /// Subtitled also requires a [subtitle] and places
  /// the [title] and [subtitle] in a column.
  CustomAppBar.subtitled({
    super.key,
    super.actions,
    super.automaticallyImplyLeading,
    super.bottom,
    bool centerTitle = _defaultCenterTitle,
    super.leading,
    Widget? subtitle,
    String? subtitleText,
    Widget? title,
    String? titleText,
  })  : assert(
          title != null || titleText != null,
          'One of title or titleText must be supplied.',
        ),
        assert(
          subtitle != null || subtitleText != null,
          'One of subtitle or subtitleText must be supplied.',
        ),
        super(
          centerTitle: centerTitle,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              title ??
                  Text(
                    titleText!,
                    textAlign: TextAlign.left,
                  ),
              subtitle ??
                  Text(
                    subtitleText!,
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.left,
                  ),
            ],
          ),
        );
}
