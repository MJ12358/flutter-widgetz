part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSearchBar}
/// A [TextFormField] made to appear like a search bar.
/// {@endtemplate}
class CustomSearchBar extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomSearchBar}
  const CustomSearchBar({
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

  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool isVisible;
  final TextInputType keyboardType;
  final String labelText;
  final VoidCallback? onClear;
  final EdgeInsets padding;
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
        widget.onClear!();
        _controller.clear();
      },
    );
  }
}
