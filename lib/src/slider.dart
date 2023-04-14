part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSlider}
/// A [Slider] wrapped in an [InputDecorator].
/// {@endtemplate}
class CustomSlider extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomSlider}
  const CustomSlider({
    Key? key,
    required this.onChanged,
    required this.value,
    this.divisions,
    this.labelText,
    this.max = 1.0,
    this.min = 0.0,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  /// Called when the user is done selecting a new value for the slider.
  final ValueChanged<num> onChanged;

  /// The currently selected value for this slider.
  final num value;

  /// The number of discrete divisions.
  final int? divisions;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The maximum value the user can select.
  final double max;

  /// The minimum value the user can select.
  final double min;

  /// An icon that appears before the editable part of the text field.
  final IconData? prefixIcon;

  /// An icon that appears after the editable part of the text field.
  final IconData? suffixIcon;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late num _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
      ),
      child: Slider.adaptive(
        divisions: widget.divisions,
        label: _value.toString(),
        onChanged: _handleChanged,
        onChangeEnd: widget.onChanged,
        max: widget.max,
        min: widget.min,
        value: _value.toDouble(),
      ),
    );
  }

  void _handleChanged(double value) {
    setState(() {
      _value = _value is int ? value.toInt() : value;
    });
  }
}
