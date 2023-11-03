part of flutter_widgetz;

/// {@template flutter_widgetz.Welcome}
/// A welcome widget.
/// {@endtemplate}
class Welcome extends StatefulWidget {
  /// {@macro flutter_widgetz.Welcome}
  const Welcome({
    super.key,
    required this.pages,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.duration = const Duration(milliseconds: 500),
    this.height = 8.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.onCompleted,
    this.skipText = 'Skip',
    this.startText = 'Start',
  });

  /// Creates a scrollable list that works
  /// page by page from an explicit [List] of widgets.
  final List<Widget> pages;

  /// The border radius of the indicators.
  final BorderRadius borderRadius;

  /// The animation duration.
  final Duration duration;

  /// The height of the indicators.
  final double height;

  /// The margin of the indicators.
  final EdgeInsets margin;

  /// A callback called when the welcome is completed.
  final VoidCallback? onCompleted;

  /// The skip text.
  final String skipText;

  /// The start text.
  final String startText;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return _WelcomeBackground(
      children: <Widget>[
        PageView(
          onPageChanged: _onPageChanged,
          children: widget.pages,
        ),
        _WelcomeIndicators(
          borderRadius: widget.borderRadius,
          currentPage: _currentPage,
          duration: widget.duration,
          height: widget.height,
          length: widget.pages.length,
          margin: widget.margin,
        ),
        _WelcomeButton(
          currentPage: _currentPage,
          duration: widget.duration,
          length: widget.pages.length,
          onTap: () => widget.onCompleted?.call(),
          skipText: widget.skipText,
          startText: widget.startText,
        ),
      ],
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
  });

  final String asset;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.all(32.0 * 1.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            asset,
            color: theme.colorScheme.primary,
            height: mediaQuery.size.height / 2,
            width: mediaQuery.size.width * 0.70,
          ),
          const SizedBox(height: 20.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _WelcomeBackground extends StatelessWidget {
  const _WelcomeBackground({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Image.asset(
            _kWelcomeTopImage,
            color: theme.colorScheme.primary,
            scale: 2.0,
            package: _kPackage,
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Image.asset(
            _kWelcomeBottomImage,
            color: theme.colorScheme.primary,
            scale: 1.75,
            package: _kPackage,
          ),
        ),
        ...children,
      ],
    );
  }
}

class _WelcomeIndicators extends StatelessWidget {
  const _WelcomeIndicators({
    required this.borderRadius,
    required this.currentPage,
    required this.duration,
    required this.height,
    required this.length,
    required this.margin,
  });

  final BorderRadius borderRadius;
  final int currentPage;
  final Duration duration;
  final double height;
  final int length;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 72.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          length,
          (int index) => _WelcomeIndicator(
            borderRadius: borderRadius,
            currentPage: currentPage,
            duration: duration,
            height: height,
            index: index,
            margin: margin,
          ),
        ),
      ),
    );
  }
}

class _WelcomeIndicator extends StatelessWidget {
  const _WelcomeIndicator({
    required this.borderRadius,
    required this.currentPage,
    required this.duration,
    required this.height,
    required this.index,
    required this.margin,
  });

  final BorderRadius borderRadius;
  final int currentPage;
  final Duration duration;
  final double height;
  final int index;
  final EdgeInsets margin;

  bool get _isCurrent => currentPage == index;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedContainer(
      duration: duration,
      margin: margin,
      height: height,
      width: _isCurrent ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: _isCurrent ? theme.colorScheme.primary : Colors.grey,
        borderRadius: borderRadius,
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  const _WelcomeButton({
    required this.currentPage,
    required this.duration,
    required this.length,
    required this.onTap,
    required this.skipText,
    required this.startText,
  });

  final int currentPage;
  final Duration duration;
  final int length;
  final VoidCallback onTap;
  final String skipText;
  final String startText;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Positioned(
      bottom: 0.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          height: theme.buttonTheme.height * 1.5,
          width: mediaQuery.size.width,
          child: Center(
            child: AnimatedCrossFade(
              duration: duration,
              crossFadeState: currentPage == length - 1
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: _WelcomeButtonText(text: skipText),
              secondChild: _WelcomeButtonText(text: startText),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeButtonText extends StatelessWidget {
  const _WelcomeButtonText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Text(
      text,
      style: TextStyle(
        color: theme.colorScheme.primary,
        letterSpacing: 1.50,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
