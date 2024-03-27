part of flutter_widgetz;

/// {@template flutter_widgetz.SearchBar}
/// A [TextFormField] made to appear like a search bar.
/// {@endtemplate}
class CustomSearchBar extends StatefulWidget {
  /// {@macro flutter_widgetz.SearchBar}
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.alignment = Alignment.topCenter,
    this.autofocus = false,
    this.duration = kThemeChangeDuration,
    this.focusNode,
    this.isVisible = true,
    this.keyboardType = TextInputType.text,
    this.labelText = 'Search',
    this.onClear,
    this.padding = EdgeInsets.zero,
    this.prefixIcon = const Icon(Icons.search),
    this.value = '',
  });

  /// Called when the value of the search bar changes.
  final ValueChanged<String> onChanged;

  /// The alignment of the child within the parent.
  final Alignment alignment;

  /// Determines whether to auto focus this input.
  final bool autofocus;

  /// The duration when transitioning this widget's size.
  final Duration duration;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Determines whether to show this input.
  final bool isVisible;

  /// The type of information for which to optimize the text input control.
  final TextInputType keyboardType;

  /// Optional text that describes the input field.
  final String labelText;

  /// Called when clearing the input.
  final VoidCallback? onClear;

  /// The amount of space by which to inset the child.
  final EdgeInsets padding;

  /// An icon that appears before the editable part of the text field.
  final Widget prefixIcon;

  /// The text value of this input.
  final String value;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: widget.alignment,
      duration: widget.duration == Duration.zero
          // zero duration causes an error
          ? const Duration(milliseconds: 1)
          : widget.duration,
      child: !widget.isVisible
          ? const SizedBox()
          : Padding(
              padding: widget.padding,
              child: TextFormField(
                autofocus: widget.autofocus,
                controller: _controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: _getSuffix(),
                ),
                onChanged: widget.onChanged,
              ),
            ),
    );
  }

  Widget? _getSuffix() {
    if (widget.onClear == null) {
      return null;
    }
    return InkWell(
      child: const Icon(Icons.close),
      onTap: () {
        widget.onClear?.call();
        _controller.clear();
      },
    );
  }
}
