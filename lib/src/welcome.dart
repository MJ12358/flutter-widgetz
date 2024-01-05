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
    this.skip = const Text('Skip'),
    this.start = const Text('Start'),
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

  /// The skip widget.
  final Widget skip;

  /// The start widget.
  final Widget start;

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
    return WelcomeBackground(
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
          skip: widget.skip,
          start: widget.start,
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

/// {@template flutter_widgetz.WelcomeContent}
/// Content for a welcome screen.
/// {@endtemplate}
class WelcomeContent extends StatelessWidget {
  /// {@macro flutter_widgetz.WelcomeContent}
  const WelcomeContent({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
    this.color,
  });

  /// The asset path to be used.
  final String asset;

  /// The title for this content.
  final String title;

  /// The description for this content.
  final String description;

  /// The color of the [asset].
  final Color? color;

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
            color: color,
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

/// {@template flutter_widgetz.WelcomeBackground}
/// Background for the welcome.
/// {@endtemplate}
class WelcomeBackground extends StatelessWidget {
  /// {@macro flutter_widgetz.WelcomeBackground}
  const WelcomeBackground({
    super.key,
    required this.children,
    this.alignment = AlignmentDirectional.bottomCenter,
    this.clipBehavior = Clip.hardEdge,
    this.fit = StackFit.loose,
  });

  final List<Widget> children;
  final AlignmentDirectional alignment;
  final Clip clipBehavior;
  final StackFit fit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      alignment: alignment,
      clipBehavior: clipBehavior,
      fit: fit,
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
    required this.skip,
    required this.start,
  });

  final int currentPage;
  final Duration duration;
  final int length;
  final VoidCallback onTap;
  final Widget skip;
  final Widget start;

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
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: theme.colorScheme.primary,
              letterSpacing: 1.50,
              fontWeight: FontWeight.bold,
            ),
            child: Center(
              child: AnimatedCrossFade(
                duration: duration,
                crossFadeState: currentPage == length - 1
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: skip,
                secondChild: start,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
