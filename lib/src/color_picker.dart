part of flutter_widgetz;

/// {@template flutter_widgetz.CustomColorPicker}
/// A color picker that represents
/// all [MaterialColor] via a [GridView].
/// {@endtemplate}
class CustomColorPicker extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomColorPicker}
  CustomColorPicker({
    Key? key,
    required this.onTap,
    this.title = 'Choose Color',
    this.initialColor,
    List<Color>? colors,
  }) : super(key: key) {
    this.colors = colors ??
        Colors.primaries.map((MaterialColor color) => color.shade500).toList();
  }

  /// Callback when a color is tapped
  final void Function(Color) onTap;

  /// A title shown above the picker
  final String title;

  /// The initial color for the picker
  final Color? initialColor;

  /// A list of Colors to display
  ///
  /// Defaults to `Colors.primaries`
  late final List<Color> colors;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.title),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 75.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: widget.colors.length,
              itemBuilder: (BuildContext context, int index) {
                return _Dot(
                  color: widget.colors[index],
                  isSelected: widget.colors[index] == selectedColor,
                  onTap: (Color color) {
                    setState(() {
                      selectedColor = color;
                    });
                    widget.onTap(color);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final void Function(Color) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(color),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: Center(
          child: isSelected
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
