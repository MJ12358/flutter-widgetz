part of flutter_widgetz;

/// {@template flutter_widgetz.Alert}
/// Alert banners communicate a state.
///
///![Alert](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/alert.png)
/// {@endtemplate}
class Alert extends StatefulWidget {
  /// {@macro flutter_widgetz.Alert}
  const Alert({
    super.key,
    this.alignment = _defaultAlignment,
    this.child = const SizedBox.shrink(),
    this.closeIcon = _defaultCloseIcon,
    this.color = _defaultColor,
    this.duration = _defaultDuration,
    this.icon = _defaultIcon,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  });

  /// The alignment of the child within the parent.
  final Alignment alignment;

  /// The widget shown inside the alert.
  final Widget child;

  /// The icon used to close the alert.
  final Widget closeIcon;

  /// The color of the alert. Defaults to a light grey.
  final Color color;

  /// The duration when transitioning this widgets size.
  final Duration duration;

  /// The icon shown to the left of the [child].
  final Widget icon;

  /// Determines if this alert is visible.
  final bool isVisible;

  /// A function called when the close icon is pressed.
  final VoidCallback? onClose;

  /// The [child] is placed inside this padding.
  final EdgeInsets padding;

  static const Alignment _defaultAlignment = Alignment.topCenter;
  static const Widget _defaultCloseIcon = Icon(Icons.close);
  static const Color _defaultColor = Color(0xFF717171);
  static const Duration _defaultDuration = kThemeAnimationDuration;
  static const Widget _defaultIcon = Icon(Icons.person);
  static const bool _defaultIsVisible = true;
  static const EdgeInsets _defaultPadding = EdgeInsets.all(8.0);

  /// {@macro flutter_widgetz.Alert}
  ///
  /// An error uses [Icons.block] and a red color.
  const Alert.error({
    super.key,
    required this.child,
    this.alignment = _defaultAlignment,
    this.closeIcon = _defaultCloseIcon,
    this.duration = _defaultDuration,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFFEA001E),
        icon = const Icon(Icons.block);

  /// {@macro flutter_widgetz.Alert}
  ///
  /// Info uses [Icons.info] and a light grey color.
  const Alert.info({
    super.key,
    required this.child,
    this.alignment = _defaultAlignment,
    this.closeIcon = _defaultCloseIcon,
    this.duration = _defaultDuration,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFF9B9B9B),
        icon = const Icon(Icons.info);

  /// {@macro flutter_widgetz.Alert}
  ///
  /// Offline uses [Icons.wifi] and a dark grey color.
  const Alert.offline({
    super.key,
    required this.child,
    this.alignment = _defaultAlignment,
    this.closeIcon = _defaultCloseIcon,
    this.duration = _defaultDuration,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFF444444),
        icon = const Icon(Icons.wifi);

  /// {@macro flutter_widgetz.Alert}
  ///
  /// A warning uses [Icons.warning] and a yellow color.
  const Alert.warning({
    super.key,
    required this.child,
    this.alignment = _defaultAlignment,
    this.closeIcon = _defaultCloseIcon,
    this.duration = _defaultDuration,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFFF89038),
        icon = const Icon(Icons.warning);

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.isVisible;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final Color _color = widget.color.blackOrWhite;

    return IconTheme(
      data: _theme.iconTheme.copyWith(
        color: _color,
      ),
      child: AnimatedSize(
        alignment: widget.alignment,
        duration: widget.duration == Duration.zero
            // zero duration causes an error
            ? const Duration(milliseconds: 1)
            : widget.duration,
        child: !_isVisible
            ? const SizedBox.shrink()
            : Container(
                color: widget.color,
                padding: widget.padding,
                width: _mediaQuery.size.width,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: widget.icon,
                    ),
                    Expanded(
                      child: DefaultTextStyle.merge(
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          color: _color,
                        ),
                        child: widget.child,
                      ),
                    ),
                    InkWell(
                      onTap: _onTap,
                      child: widget.closeIcon,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      _isVisible = !_isVisible;
    });
    widget.onClose?.call();
  }
}
