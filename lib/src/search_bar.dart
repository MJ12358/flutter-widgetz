part of flutter_widgetz;

/// {@template flutter_widgetz.SearchBar}
/// A [TextFormField] made to appear like a search bar.
/// {@endtemplate}
class SearchBar extends StatefulWidget {
  /// {@macro flutter_widgetz.SearchBar}
  const SearchBar({
    Key? key,
    required this.onChanged,
    this.autofocus = false,
    this.isVisible = true,
    this.keyboardType = TextInputType.text,
    this.labelText = 'Search',
    this.onClear,
    this.padding = EdgeInsets.zero,
    this.value = '',
  }) : super(key: key);

  /// Called when the value of the search bar changes.
  final ValueChanged<String> onChanged;

  /// Determines whether to auto focus this input.
  final bool autofocus;

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

  /// The text value of this input.
  final String value;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
    if (!widget.isVisible) {
      return const SizedBox();
    }

    return Padding(
      padding: widget.padding,
      child: TextFormField(
        autofocus: widget.autofocus,
        controller: _controller,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _getSuffix(),
        ),
        onChanged: widget.onChanged,
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
