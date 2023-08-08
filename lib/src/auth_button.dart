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

  bool get isDark =>
      Theme.of(context).scaffoldBackgroundColor.brightness == Brightness.dark;

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
        icon = Image.asset('assets/icons/google.png');

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates an Apple themed button.
  ///
  /// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple
  const AuthButton.apple({
    super.key,
    this.color = const Color(0xFF000000),
    this.icon = const Icon(Icons.text_snippet),
    required this.onTap,
    this.text = 'Sign in With Apple',
  });

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a GitHub themed button.
  ///
  /// https://github.com/logos
  const AuthButton.github({
    super.key,
    this.color = const Color(0xFF24292E),
    this.icon = const Icon(Icons.text_snippet),
    required this.onTap,
    this.text = 'Sign in With GitHub',
  });

  /// {@macro flutter_widgetz.AuthButton}
  ///
  /// This creates a Microsoft themed button.
  ///
  /// https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-add-branding-in-apps
  const AuthButton.microsoft({
    super.key,
    this.color = const Color(0xFFFFFFFF),
    this.icon = const Icon(Icons.text_snippet),
    required this.onTap,
    this.text = 'Sign in With Microsoft',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.only(right: 8.0),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Theme.of(context).buttonTheme.height,
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
                child: icon,
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
