part of flutter_widgetz;

/// {@template flutter_widgetz.Alert}
/// Alert banners communicate a state.
/// {@endtemplate}
class Alert extends StatefulWidget {
  /// {@macro flutter_widgetz.Alert}
  const Alert({
    super.key,
    this.child = const SizedBox(),
    this.closeIcon = _defaultCloseIcon,
    this.color = _defaultColor,
    this.icon = _defaultIcon,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  });

  /// The widget shown inside the alert.
  final Widget child;

  /// The icon used to close the alert.
  final IconData closeIcon;

  /// The color of the alert. Defaults to a light grey.
  final Color color;

  /// The icon shown to the left of the [child].
  final IconData icon;

  /// Determines if this alert is visible.
  final bool isVisible;

  /// A function called when the close icon is pressed.
  final VoidCallback? onClose;

  /// The [child] is placed inside this padding.
  final EdgeInsets padding;

  static const IconData _defaultCloseIcon = Icons.close;
  static const Color _defaultColor = Color(0xFF717171);
  static const IconData _defaultIcon = Icons.person;
  static const bool _defaultIsVisible = true;
  static const EdgeInsets _defaultPadding = EdgeInsets.all(8.0);

  /// {@macro flutter_widgetz.Alert}
  ///
  /// An error uses [Icons.block] and a red color.
  const Alert.error({
    super.key,
    required this.child,
    this.closeIcon = _defaultCloseIcon,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFFEA001E),
        icon = Icons.block;

  /// {@macro flutter_widgetz.Alert}
  ///
  /// Offline uses [Icons.wifi] and a dark grey color.
  const Alert.offline({
    super.key,
    required this.child,
    this.closeIcon = _defaultCloseIcon,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFF444444),
        icon = Icons.wifi;

  /// {@macro flutter_widgetz.Alert}
  ///
  /// A warning uses [Icons.warning] and a yellow color.
  const Alert.warning({
    super.key,
    required this.child,
    this.closeIcon = _defaultCloseIcon,
    this.isVisible = _defaultIsVisible,
    this.onClose,
    this.padding = _defaultPadding,
  })  : color = const Color(0xFFF89038),
        icon = Icons.warning;

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
    if (!_isVisible) {
      return const SizedBox();
    }

    return Container(
      color: widget.color,
      padding: widget.padding,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              widget.icon,
              color: widget.color.blackOrWhite,
            ),
          ),
          DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.color.blackOrWhite,
                ),
            child: widget.child,
          ),
          const Spacer(),
          GestureDetector(
            onTap: _onTap,
            child: Icon(
              widget.closeIcon,
              color: widget.color.blackOrWhite,
            ),
          ),
        ],
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
