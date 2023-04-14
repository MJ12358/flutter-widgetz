part of flutter_widgetz;

/// {@template flutter_widgetz.Alert}
/// Alert banners communicate a state.
/// {@endtemplate}
class Alert extends StatefulWidget {
  /// {@macro flutter_widgetz.Alert}
  const Alert({
    Key? key,
    this.child = const SizedBox(),
    this.closeIcon = Icons.close,
    this.color = const Color(0xFF717171),
    this.icon = Icons.person,
    this.isVisible = true,
    this.onClose,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  final Widget child;
  final IconData closeIcon;
  final Color color;
  final IconData icon;
  final bool isVisible;
  final VoidCallback? onClose;
  final EdgeInsets padding;

  /// {@macro flutter_widgetz.Alert}
  factory Alert.warning({
    required Widget child,
    VoidCallback? onClose,
  }) {
    return Alert(
      color: const Color(0xFFF89038),
      icon: Icons.warning,
      onClose: onClose,
      child: child,
    );
  }

  /// {@macro flutter_widgetz.Alert}
  factory Alert.error({
    required Widget child,
    VoidCallback? onClose,
  }) {
    return Alert(
      color: const Color(0xFFEA001E),
      icon: Icons.block,
      onClose: onClose,
      child: child,
    );
  }

  /// {@macro flutter_widgetz.Alert}
  factory Alert.offline({
    required Widget child,
    VoidCallback? onClose,
  }) {
    return Alert(
      color: const Color(0xFF444444),
      icon: Icons.wifi,
      onClose: onClose,
      child: child,
    );
  }

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
            onTap: _handleTap,
            child: Icon(
              widget.closeIcon,
              color: widget.color.blackOrWhite,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _isVisible = !_isVisible;
    });
    widget.onClose?.call();
  }
}
