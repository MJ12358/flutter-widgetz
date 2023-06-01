part of flutter_widgetz;

/// {@template flutter_widgetz.CustomNavigationRail}
/// A wrapper for [NavigationRail] that handles
/// the `selectedIndex` for you.
/// {@endtemplate}
class CustomNavigationRail extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomNavigationRail}
  const CustomNavigationRail({
    super.key,
    required this.destinations,
    this.backgroundColor,
    this.elevation,
    this.extended = false,
    this.indicatorColor,
    this.indicatorShape,
    this.labelType,
    this.leading,
    this.onDestinationSelected,
    this.trailing,
    this.useIndicator,
  });

  /// Defines the appearance of the button items
  /// that are arrayed within the navigation rail.
  final List<NavigationRailDestination> destinations;

  /// Sets the color of the Container that holds
  /// all of the [NavigationRail]'s contents.
  final Color? backgroundColor;

  /// The rail's elevation or z-coordinate.
  final double? elevation;

  /// Indicates that the [NavigationRail] should be
  /// in the extended state.
  final bool extended;

  /// Overrides the default value of [NavigationRail]'s
  /// selection indicator color, when [useIndicator] is true.
  final Color? indicatorColor;

  /// Overrides the default value of [NavigationRail]'s
  /// selection indicator shape, when [useIndicator] is true.
  final ShapeBorder? indicatorShape;

  /// Defines the layout and behavior of the labels
  /// for the default, unextended [NavigationRail].
  final NavigationRailLabelType? labelType;

  /// The leading widget in the rail that is placed
  /// above the destinations.
  final Widget? leading;

  /// Called when one of the [destinations] is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// The trailing widget in the rail that is placed
  /// below the destinations.
  final Widget? trailing;

  /// If true, adds a rounded [NavigationIndicator]
  /// behind the selected destination's icon.
  final bool? useIndicator;

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  int _selelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: widget.backgroundColor,
      destinations: widget.destinations,
      elevation: widget.elevation,
      extended: widget.extended,
      indicatorColor: widget.indicatorColor,
      indicatorShape: widget.indicatorShape,
      labelType: widget.labelType,
      leading: widget.leading,
      onDestinationSelected: _onDestinationSelected,
      selectedIndex: _selelectedIndex,
      trailing: widget.trailing,
      useIndicator: widget.useIndicator,
    );
  }

  void _onDestinationSelected(int value) {
    setState(() {
      _selelectedIndex = value;
    });
    widget.onDestinationSelected?.call(value);
  }
}
