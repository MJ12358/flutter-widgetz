part of flutter_widgetz;

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required this.searchValue,
    required this.onClear,
    required this.onChanged,
    this.autofocus = false,
    this.isVisible = true,
    this.keyboardType = TextInputType.text,
    this.labelText = 'Search',
  }) : super(key: key);

  final String searchValue;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool isVisible;
  final TextInputType keyboardType;
  final String labelText;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.searchValue;
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
      // TODO: to use padding or not to use padding
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        autofocus: widget.autofocus,
        controller: _controller,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: InkWell(
            child: const Icon(Icons.close),
            onTap: () {
              widget.onClear();
              _controller.clear();
            },
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
