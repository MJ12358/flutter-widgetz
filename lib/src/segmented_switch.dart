part of flutter_widgetz;

/// {@template flutter_widgetz.SegmentedSwitch}
/// A segmented switch that allows users to select
/// one option from a set of options.
///
/// ![SegmentedSwitch](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/segmented_switch.png)
/// {@endtemplate}
class SegmentedSwitch<T extends Object> extends StatefulWidget {
  /// {@macro flutter_widgetz.SegmentedSwitch}
  const SegmentedSwitch({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTextColor,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(kRadialReactionRadius),
    ),
    this.curve = Curves.easeOutCubic,
    this.duration = kThemeChangeDuration,
    this.displayStringForOption = _defaultStringForOption,
    this.height = kToolbarHeight,
    this.inactiveTextColor,
  });

  /// The list of options the user can select.
  final List<T> options;

  /// The currently selected value.
  final T value;

  /// Called when the user selects an option.
  final ValueChanged<T> onChanged;

  /// The color of the active option.
  ///
  /// Defaults to the primary color of the theme.
  final Color? activeColor;

  /// The color of the text for the active option.
  final Color? activeTextColor;

  /// The background color of the switch.
  final Color? backgroundColor;

  /// The border radius of the switch.
  final BorderRadiusGeometry borderRadius;

  /// The curve of the animation when switching options.
  final Curve curve;

  /// The duration of the animation when switching options.
  final Duration duration;

  /// The function used to get the display string for each option.
  final String Function(T) displayStringForOption;

  /// The height of the switch.
  final double height;

  /// The color of the text for the inactive options.
  final Color? inactiveTextColor;

  static String _defaultStringForOption(Object option) {
    return option.toString();
  }

  @override
  State<SegmentedSwitch<T>> createState() => _SegmentedSwitchState<T>();
}

class _SegmentedSwitchState<T extends Object>
    extends State<SegmentedSwitch<T>> {
  late T _currentValue;

  int get _selectedIndex {
    final int index = widget.options.indexOf(_currentValue);
    return index < 0 ? 0 : index;
  }

  Color get _activeColor =>
      widget.activeColor ?? Theme.of(context).colorScheme.primary;

  Color get _backgroundColor =>
      widget.backgroundColor ?? Theme.of(context).colorScheme.surface;

  Color get _activeTextColor =>
      widget.activeTextColor ??
      Theme.of(context).colorScheme.primary.blackOrWhite;

  Color get _inactiveTextColor =>
      widget.inactiveTextColor ?? Theme.of(context).colorScheme.onSurface;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(SegmentedSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only sync if parent actually changed the value externally
    if (oldWidget.value != widget.value && widget.value != _currentValue) {
      _currentValue = widget.value;
    }
  }

  void _onTap(T option) {
    if (option == _currentValue) {
      return;
    }
    setState(() {
      _currentValue = option;
    });
    widget.onChanged(option);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _selectedIndex;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double itemWidth = constraints.maxWidth / widget.options.length;

        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: Stack(
            children: <Widget>[
              _SegmentedSwitchPill(
                activeColor: _activeColor,
                borderRadius: widget.borderRadius,
                curve: widget.curve,
                duration: widget.duration,
                itemWidth: itemWidth,
                selectedIndex: selectedIndex,
              ),
              Row(
                children: <Widget>[
                  for (int i = 0; i < widget.options.length; i++)
                    _SegmentedSwitchOption(
                      duration: widget.duration,
                      isSelected: i == selectedIndex,
                      activeTextColor: _activeTextColor,
                      inactiveTextColor: _inactiveTextColor,
                      onTap: () => _onTap(widget.options[i]),
                      child: Text(
                        widget.displayStringForOption(widget.options[i]),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SegmentedSwitchPill extends StatelessWidget {
  const _SegmentedSwitchPill({
    required this.activeColor,
    required this.borderRadius,
    required this.curve,
    required this.duration,
    required this.itemWidth,
    required this.selectedIndex,
  });

  final Color activeColor;
  final BorderRadiusGeometry borderRadius;
  final Curve curve;
  final Duration duration;
  final double itemWidth;
  final int selectedIndex;

  static const double _radius = 4.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      curve: curve,
      left: itemWidth * selectedIndex,
      width: itemWidth,
      top: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(_radius),
        child: Container(
          decoration: BoxDecoration(
            color: activeColor,
            borderRadius: borderRadius
                .resolve(TextDirection.ltr)
                .subtract(const BorderRadius.all(Radius.circular(_radius))),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                blurRadius: _radius,
                offset: Offset(0, 2),
                color: Color(0x22000000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentedSwitchOption extends StatelessWidget {
  const _SegmentedSwitchOption({
    required this.child,
    required this.duration,
    required this.isSelected,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.onTap,
  });

  final Widget child;
  final Duration duration;
  final bool isSelected;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: duration,
            style: TextStyle(
              color: isSelected ? activeTextColor : inactiveTextColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
