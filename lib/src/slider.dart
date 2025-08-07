part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSlider}
/// A [Slider] wrapped in an [InputDecorator].
///
///![CustomSlider](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/slider.png)
/// {@endtemplate}
class CustomSlider extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomSlider}
  const CustomSlider({
    super.key,
    required this.onChanged,
    this.divisions,
    this.labelText,
    this.max = 1.0,
    this.min = 0.0,
    this.prefixIcon,
    this.suffixIcon,
    this.value = 0,
  });

  /// Called when the user is done selecting a new value for the slider.
  final ValueChanged<num> onChanged;

  /// The number of discrete divisions.
  final int? divisions;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The maximum value the user can select.
  final double max;

  /// The minimum value the user can select.
  final double min;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// An icon that appears after the editable part of the text field.
  final Widget? suffixIcon;

  /// The currently selected value for this slider.
  final num value;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late final FocusNode _focusNode;
  late num _value;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: _onFocusChange,
      child: InputDecorator(
        isFocused: _focusNode.hasFocus,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
        child: Slider(
          divisions: widget.divisions,
          label: _value.toString(),
          onChanged: _onChanged,
          onChangeEnd: widget.onChanged,
          max: widget.max,
          min: widget.min,
          value: _value.toDouble(),
        ),
      ),
    );
  }

  void _onChanged(double value) {
    setState(() {
      _value = value is int ? value.toInt() : value;
    });
  }

  void _onFocusChange(bool value) {
    if (value) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
    setState(() {});
  }
}
