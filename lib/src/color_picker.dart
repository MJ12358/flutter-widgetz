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
    this.initialColor,
    this.padding = _defaultPadding,
    String? title,
    this.titleStyle,
  })  : colors = colors ?? _defaultColors,
        title = title ?? _defaultTitle;

  /// Callback when a color is tapped.
  final ValueChanged<Color> onTap;

  /// The decoration to use for the background.
  final BoxDecoration decoration;

  /// A list of Colors to display.
  ///
  /// Defaults to [Colors.primaries].
  late final List<Color> colors;

  /// The initial color for the picker.
  final Color? initialColor;

  /// Empty space to inscribe inside the picker;
  final EdgeInsets padding;

  /// A title shown above the picker.
  final String title;

  /// The style to use for the [title].
  final TextStyle? titleStyle;

  static List<Color> get _defaultColors =>
      Colors.primaries.map((MaterialColor color) => color.shade500).toList();
  static const EdgeInsets _defaultPadding = EdgeInsets.all(16.0);
  static const String _defaultTitle = 'Choose Color';

  /// {@macro flutter_widgetz.ColorPicker}
  ///
  /// Circle uses a [BoxDecoration] with [BoxShape.circle].
  ColorPicker.circle({
    super.key,
    required this.onTap,
    List<Color>? colors,
    this.initialColor,
    this.padding = _defaultPadding,
    this.title = _defaultTitle,
    this.titleStyle,
  })  : colors = colors ?? _defaultColors,
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
    this.initialColor,
    this.padding = _defaultPadding,
    this.title = _defaultTitle,
    this.titleStyle,
  })  : colors = colors ?? _defaultColors,
        decoration = BoxDecoration(
          border: Border.all(),
        );

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    if (widget.initialColor is MaterialColor?) {
      final MaterialColor? _materialColor =
          widget.initialColor as MaterialColor?;
      _selectedColor = _materialColor?.shade500;
    } else {
      _selectedColor = widget.initialColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.maxFinite,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: widget.padding.copyWith(bottom: 0.0),
                child: Text(
                  widget.title,
                  style: widget.titleStyle ??
                      Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: widget.padding,
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 75.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: widget.colors.length,
                itemBuilder: (_, int index) {
                  final Color color = widget.colors[index];
                  return _Dot(
                    color: color,
                    decoration: widget.decoration,
                    isSelected: color == _selectedColor,
                    onTap: _onTap,
                  );
                },
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
      customBorder: Border.all(),
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
