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
    List<Color>? colors,
    this.initialColor,
    this.padding = const EdgeInsets.all(16.0),
    this.shape = BoxShape.circle,
    this.title = 'Choose Color',
    this.titleStyle,
  }) {
    this.colors = colors ??
        Colors.primaries.map((MaterialColor color) => color.shade500).toList();
  }

  /// Callback when a color is tapped.
  final ValueChanged<Color> onTap;

  /// A list of Colors to display.
  ///
  /// Defaults to [Colors.primaries].
  late final List<Color> colors;

  /// The initial color for the picker.
  final Color? initialColor;

  /// Empty space to inscribe inside the picker;
  final EdgeInsets padding;

  /// The shape to fill the background.
  final BoxShape shape;

  /// A title shown above the picker.
  final String title;

  /// The style to use for the [title].
  final TextStyle? titleStyle;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
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
                    isSelected: color == _selectedColor,
                    onTap: _onTap,
                    shape: widget.shape,
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
    required this.isSelected,
    required this.onTap,
    required this.shape,
  });

  final Color color;
  final bool isSelected;
  final void Function(Color) onTap;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: Border.all(),
      onTap: () => onTap(color),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: color,
          shape: shape,
          border: Border.all(),
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
