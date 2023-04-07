part of flutter_widgetz;

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required this.onChanged,
    this.autofocus = false,
    this.isVisible = true,
    this.keyboardType = TextInputType.text,
    this.labelText = 'Search',
    this.onClear,
    this.value = '',
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool isVisible;
  final TextInputType keyboardType;
  final String labelText;
  final VoidCallback? onClear;
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

    return TextFormField(
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
