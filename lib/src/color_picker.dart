part of flutter_widgetz;

/// {@template flutter_widgetz.ColorPicker}
/// A color picker that represents
/// all [MaterialColor] via a [GridView].
/// {@endtemplate}
class ColorPicker extends StatefulWidget {
  /// {@macro flutter_widgetz.ColorPicker}
  ColorPicker({
    super.key,
    required this.onTap,
    required this.decoration,
    List<Color>? colors,
    this.extent = _defaultExtent,
    this.initialColor,
    this.padding = _defaultPadding,
    double? spacing,
    Widget? title,
  })  : colors = colors ?? _defaultColors,
        spacing = spacing ?? _defaultSpacing,
        title = title ?? _defaultTitle,
        isCompact = false;

  /// Callback when a color is tapped.
  final ValueChanged<Color> onTap;

  /// The decoration to use for the background.
  final BoxDecoration decoration;

  /// A list of Colors to display.
  ///
  /// Defaults to [Colors.primaries].
  late final List<Color> colors;

  /// The maximum extent of tiles.
  final double extent;

  /// The initial color for the picker.
  final Color? initialColor;

  /// Empty space to inscribe inside the picker;
  final EdgeInsets padding;

  /// The number of logical pixels between each child.
  final double spacing;

  /// A title shown above the picker.
  final Widget? title;

  /// Determines whether to use a compact horizontal list.
  final bool isCompact;

  static List<Color> get _defaultColors =>
      Colors.primaries.map((MaterialColor color) => color.shade500).toList();
  static const double _defaultExtent = 75.0;
  static const EdgeInsets _defaultPadding = EdgeInsets.all(16.0);
  static const double _defaultSpacing = 10.0;
  static const Widget _defaultTitle = Text('Choose Color');

  /// {@macro flutter_widgetz.ColorPicker}
  ///
  /// Circle uses a [BoxDecoration] with [BoxShape.circle].
  ColorPicker.circle({
    super.key,
    required this.onTap,
    List<Color>? colors,
    this.extent = _defaultExtent,
    this.initialColor,
    this.padding = _defaultPadding,
    this.spacing = _defaultSpacing,
    this.title = _defaultTitle,
  })  : colors = colors ?? _defaultColors,
        isCompact = false,
        decoration = BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
        );

  /// {@macro flutter_widgetz.ColorPicker}
  ///
  /// Circle uses a [BoxDecoration] with [BoxShape.rectangle].
  ColorPicker.rectangle({
    super.key,
    required this.onTap,
    List<Color>? colors,
    this.extent = _defaultExtent,
    this.initialColor,
    this.padding = _defaultPadding,
    this.spacing = _defaultSpacing,
    this.title = _defaultTitle,
  })  : colors = colors ?? _defaultColors,
        isCompact = false,
        decoration = BoxDecoration(
          border: Border.all(),
        );

  /// {@macro flutter_widgetz.ColorPicker}
  ///
  /// Compact uses a horizontal list.
  ColorPicker.compact({
    super.key,
    required this.onTap,
    List<Color>? colors,
    this.extent = _defaultExtent,
    this.initialColor,
    this.padding = const EdgeInsets.all(8.0),
    BoxShape? shape,
    this.spacing = _defaultSpacing,
    this.title,
  })  : colors = colors ?? _defaultColors,
        isCompact = true,
        decoration = BoxDecoration(
          border: Border.all(),
          shape: shape ?? BoxShape.circle,
        );

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = _getInitialColor();
  }

  Color? _getInitialColor() {
    final Color? initialColor = widget.initialColor;
    if (initialColor is MaterialColor?) {
      return initialColor?.shade500;
    } else {
      return widget.initialColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.maxFinite,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _Header(
                title: widget.title,
                padding: widget.padding,
              ),
            ),
            SliverPadding(
              padding: widget.padding,
              sliver: widget.isCompact
                  ? _List(
                      colors: widget.colors,
                      decoration: widget.decoration,
                      onTap: _onTap,
                      selectedColor: _selectedColor,
                      spacing: widget.spacing,
                    )
                  : _Grid(
                      colors: widget.colors,
                      decoration: widget.decoration,
                      extent: widget.extent,
                      onTap: _onTap,
                      selectedColor: _selectedColor,
                      spacing: widget.spacing,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(Color color) {
    setState(() {
      _selectedColor = color;
    });
    widget.onTap(color);
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.padding,
  });

  final Widget? title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return const SizedBox();
    }

    return Container(
      padding: padding.copyWith(bottom: 0.0),
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.titleMedium,
        child: title!,
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.colors,
    required this.decoration,
    required this.extent,
    required this.onTap,
    required this.spacing,
    this.selectedColor,
  });

  final List<Color> colors;
  final BoxDecoration decoration;
  final double extent;
  final ValueChanged<Color> onTap;
  final double spacing;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: extent,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: colors.length,
      itemBuilder: (_, int index) {
        final Color color = colors[index];
        return _Dot(
          color: color,
          decoration: decoration,
          isSelected: color == selectedColor,
          onTap: onTap,
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.colors,
    required this.decoration,
    required this.onTap,
    required this.spacing,
    this.selectedColor,
  });

  final List<Color> colors;
  final BoxDecoration decoration;
  final ValueChanged<Color> onTap;
  final double spacing;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Wrap(
        children: <Widget>[
          SizedBox(
            height: 50 + spacing,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: colors.length,
              itemBuilder: (_, int index) {
                final Color color = colors[index];
                return _Dot(
                  color: color,
                  decoration: decoration,
                  isSelected: color == selectedColor,
                  onTap: onTap,
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(width: spacing);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.color,
    required this.decoration,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final BoxDecoration decoration;
  final bool isSelected;
  final ValueChanged<Color> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => onTap(color),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: decoration.copyWith(
          color: color,
        ),
        child: Center(
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: color.blackOrWhite,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
