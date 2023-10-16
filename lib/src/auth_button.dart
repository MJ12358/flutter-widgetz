part of flutter_widgetz;

/// {@template flutter_widgetz.AuthButton}
/// An auth button with many factory constructors.
/// {@endtemplate}
class AuthButton extends StatelessWidget {
  /// {@macro flutter_widgetz.AuthButton}
  const AuthButton({
    super.key,
    required this.color,
    required this.icon,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    required this.onTap,
    required this.text,
    required this.textStyle,
  });

  /// The button's color.
  final Color color;

  /// The button's icon.
  final Widget icon;

  /// The maximum width that satisfies the constraints.
  final double maxWidth;

  /// The minimum width that satisfies the constraints.
  final double minWidth;

  /// The callback that is called when the button is tapped.
  final VoidCallback onTap;

  /// The text show within the button.
  final String text;

  /// The style to use for the text.
  final TextStyle? textStyle;

  static const double _defaultMaxWidth = 275;
  static const double _defaultMinWidth = 275;

  static Widget _getAsset(String path) {
    return Image.asset(
      path,
      package: _kPackage,
    );
  }

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates an Apple themed button.
  ///
  /// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple
  AuthButton.apple({
    super.key,
    required this.onTap,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    this.text = 'Sign in with Apple',
    this.textStyle,
  })  : color = const Color(0xFF000000),
        icon = _getAsset(_kAppleIcon);

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Facebook themed button.
  ///
  /// https://about.meta.com/brand/resources/facebookapp/logo/
  AuthButton.facebook({
    super.key,
    required this.onTap,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    this.text = 'Sign in with Facebook',
    this.textStyle,
  })  : color = const Color(0xFF43549D),
        icon = _getAsset(_kFacebookIcon);

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a GitHub themed button.
  ///
  /// https://github.com/logos
  AuthButton.github({
    super.key,
    required this.onTap,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    this.text = 'Sign in with GitHub',
    this.textStyle,
  })  : color = const Color(0xFF24292E),
        icon = _getAsset(_kGithubIcon);

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Google themed button.
  ///
  /// https://developers.google.com/identity/branding-guidelines
  AuthButton.google({
    super.key,
    required this.onTap,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    this.text = 'Sign in with Google',
    this.textStyle,
  })  : color = const Color(0xFF4285F4),
        icon = _getAsset(_kGoogleIcon);

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Microsoft themed button.
  ///
  /// https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-add-branding-in-apps
  AuthButton.microsoft({
    super.key,
    required this.onTap,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    this.text = 'Sign in with Microsoft',
    this.textStyle,
  })  : color = const Color(0xFF2F2F2F),
        icon = _getAsset(_kMicrosoftIcon);

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Twitter themed button.
  ///
  /// https://about.twitter.com/content/dam/about-twitter/en/brand-toolkit/downloads/twitter-external-brand-guidelines-01272021.pdf
  AuthButton.twitter({
    super.key,
    required this.onTap,
    this.maxWidth = _defaultMaxWidth,
    this.minWidth = _defaultMinWidth,
    this.text = 'Sign in with Twitter',
    TextStyle? textStyle,
  })  : color = const Color(0xFF55ACEE),
        icon = _getAsset(_kTwitterIcon),
        textStyle = textStyle ?? const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final double _height = Theme.of(context).buttonTheme.height;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.only(right: 8.0),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: _height,
          minWidth: minWidth,
          maxWidth: maxWidth,
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.white,
              margin: const EdgeInsets.all(1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: _height,
                  width: _height,
                  child: icon,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: textStyle ??
                    TextStyle(
                      color: color.blackOrWhite,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
