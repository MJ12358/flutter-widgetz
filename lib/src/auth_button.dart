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
    required this.onTap,
    required this.text,
  });

  /// The button's color.
  final Color color;

  /// The button's icon.
  final Widget icon;

  /// The callback that is called when the button is tapped.
  final VoidCallback onTap;

  /// The text show within the button.
  final String text;

  static Widget _getAsset(String name) {
    return Image.asset(
      'assets/icons/$name',
      package: 'flutter_widgetz',
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
    this.text = 'Sign in with Apple',
  })  : color = const Color(0xFF000000),
        icon = _getAsset('apple.png');

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Facebook themed button.
  ///
  /// https://about.meta.com/brand/resources/facebookapp/logo/
  AuthButton.facebook({
    super.key,
    required this.onTap,
    this.text = 'Sign in with Facebook',
  })  : color = const Color(0xFF43549D),
        icon = _getAsset('facebook.png');

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a GitHub themed button.
  ///
  /// https://github.com/logos
  AuthButton.github({
    super.key,
    required this.onTap,
    this.text = 'Sign in with GitHub',
  })  : color = const Color(0xFF24292E),
        icon = _getAsset('github.png');

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Google themed button.
  ///
  /// https://developers.google.com/identity/branding-guidelines
  AuthButton.google({
    super.key,
    required this.onTap,
    this.text = 'Sign in with Google',
  })  : color = const Color(0xFF4285F4),
        icon = _getAsset('google.png');

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Microsoft themed button.
  ///
  /// https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-add-branding-in-apps
  AuthButton.microsoft({
    super.key,
    required this.onTap,
    this.text = 'Sign in with Microsoft',
  })  : color = const Color(0xFF2F2F2F),
        icon = _getAsset('microsoft.png');

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Twitter themed button.
  ///
  /// https://about.twitter.com/content/dam/about-twitter/en/brand-toolkit/downloads/twitter-external-brand-guidelines-01272021.pdf
  AuthButton.twitter({
    super.key,
    required this.onTap,
    this.text = 'Sign in with Twitter',
  })  : color = const Color(0xFF55ACEE),
        icon = _getAsset('twitter.png');

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
          minWidth: 275,
          maxWidth: 275,
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
                style: TextStyle(
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
