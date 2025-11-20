part of flutter_widgetz;

/// {@template flutter_widgetz.DuelingPicklist}
/// A dueling-picklist is used to move options between
/// two lists and is often referred to as a multi-select.
///
///![DuelingPicklist](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/dueling_picklist.png)
/// {@endtemplate}
class DuelingPicklist<T extends Object> extends StatefulWidget {
  /// {@macro flutter_widgetz.DuelingPicklist}
  const DuelingPicklist({
    super.key,
    this.available = const <Never>[],
    this.availableLabel = const Text('Available'),
    this.displayStringForItem = _defaultStringForItem,
    this.height = 240.0,
    this.label,
    this.onAvailableChanged,
    this.onSelectedChanged,
    this.onSort,
    this.selected = const <Never>[],
    this.selectedLabel = const Text('Selected'),
    this.spacing = 16.0,
  });

  /// The list of available items.
  final List<T> available;

  /// A label above the available items.
  final Widget availableLabel;

  /// A callback used to display a string for an item.
  final String Function(T) displayStringForItem;

  /// The height of the picklists.
  final double height;

  /// A optional label to describe the picklists.
  final Widget? label;

  /// Called when the available items change.
  final ValueChanged<List<T>>? onAvailableChanged;

  /// Called when the selected items change.
  final ValueChanged<List<T>>? onSelectedChanged;

  /// How the items should be sorted.
  final int Function(T a, T b)? onSort;

  /// The list of selected items.
  final List<T> selected;

  /// A label above the selected items.
  final Widget selectedLabel;

  /// The spacing between the arrows and the picklists.
  final double spacing;

  static String _defaultStringForItem(Object? item) {
    return item?.toString() ?? '';
  }

  @override
  State<DuelingPicklist<T>> createState() => _DuelingPicklistState<T>();
}

class _DuelingPicklistState<T extends Object>
    extends State<DuelingPicklist<T>> {
  late List<T> _available;
  late List<T> _selected;
  late List<T> _availableMarked;
  late List<T> _selectedMarked;

  @override
  void initState() {
    super.initState();
    _available = widget.available;
    _selected = widget.selected;
    _availableMarked = <T>[];
    _selectedMarked = <T>[];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Label(child: widget.label),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _Picklist<T>(
              key: ValueKey<List<T>>(_available),
              children: _available,
              displayStringForItem: widget.displayStringForItem,
              height: widget.height,
              label: widget.availableLabel,
              onChanged: _onAvailableChanged,
              onSort: widget.onSort,
            ),
            _Arrows(
              onAdd: _onAdd,
              onRemove: _onRemove,
              spacing: widget.spacing,
            ),
            _Picklist<T>(
              key: ValueKey<List<T>>(_selected),
              children: _selected,
              displayStringForItem: widget.displayStringForItem,
              height: widget.height,
              label: widget.selectedLabel,
              onChanged: _onSelectedChanged,
              onSort: widget.onSort,
            ),
          ],
        ),
      ],
    );
  }

  void _onAdd() {
    final List<T> available = List<T>.from(_available);
    final List<T> selected = List<T>.from(_selected);
    available.removeWhere((T e) => _availableMarked.contains(e));
    selected.addAll(_availableMarked);
    _onChanged(available, selected);
  }

  void _onRemove() {
    final List<T> available = List<T>.from(_available);
    final List<T> selected = List<T>.from(_selected);
    selected.removeWhere((T e) => _selectedMarked.contains(e));
    available.addAll(_selectedMarked);
    _onChanged(available, selected);
  }

  // ignore: use_setters_to_change_properties
  void _onAvailableChanged(List<T> value) {
    _availableMarked = value;
  }

  // ignore: use_setters_to_change_properties
  void _onSelectedChanged(List<T> value) {
    _selectedMarked = value;
  }

  void _onChanged(List<T> available, List<T> selected) {
    setState(() {
      _available = available;
      _selected = selected;
    });
    widget.onAvailableChanged?.call(available);
    widget.onSelectedChanged?.call(selected);
    _availableMarked = <T>[];
    _selectedMarked = <T>[];
  }
}

class _Label extends StatelessWidget {
  const _Label({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        child: child!,
      ),
    );
  }
}

class _Arrows extends StatelessWidget {
  const _Arrows({
    required this.onAdd,
    required this.onRemove,
    required this.spacing,
  });

  final VoidCallback onAdd;

  final VoidCallback onRemove;

  final double spacing;

  double get _spacing => spacing * 2;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return IconTheme(
      data: theme.iconTheme.copyWith(
        color: theme.scaffoldBackgroundColor.blackOrWhite,
        size: _spacing,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing),
        child: Column(
          children: <Widget>[
            SizedBox(height: _spacing),
            InkWell(
              onTap: onAdd,
              child: const Icon(Icons.arrow_right),
            ),
            SizedBox(height: _spacing),
            InkWell(
              onTap: onRemove,
              child: const Icon(Icons.arrow_left),
            ),
          ],
        ),
      ),
    );
  }
}

class _Picklist<T extends Object> extends StatefulWidget {
  const _Picklist({
    super.key,
    required this.children,
    required this.displayStringForItem,
    required this.height,
    required this.label,
    required this.onChanged,
    this.onSort,
  });

  final List<T> children;
  final String Function(T) displayStringForItem;
  final double height;
  final Widget label;
  final ValueChanged<List<T>> onChanged;
  final int Function(T a, T b)? onSort;

  @override
  State<_Picklist<T>> createState() => _PicklistState<T>();
}

class _PicklistState<T extends Object> extends State<_Picklist<T>> {
  late List<T> _selection;

  @override
  void initState() {
    super.initState();
    _selection = <T>[];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: widget.label,
          ),
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.scaffoldBackgroundColor.blackOrWhite,
              ),
            ),
            child: ListView(
              children: _getChildren(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getChildren() {
    final List<T> children = List<T>.from(widget.children);

    children.sort((T a, T b) {
      return widget.onSort?.call(a, b) ??
          widget
              .displayStringForItem(a)
              .compareTo(widget.displayStringForItem(b));
    });

    return children.map((T e) {
      return _Item(
        isSelected: _selection.contains(e),
        onTap: () => _onTap(e),
        text: widget.displayStringForItem(e),
      );
    }).toList();
  }

  void _onTap(T item) {
    _selection.contains(item) ? _selection.remove(item) : _selection.add(item);
    setState(() {
      _selection = _selection;
    });
    widget.onChanged(_selection);
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.isSelected,
    required this.onTap,
    required this.text,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        dense: true,
        onTap: onTap,
        selected: isSelected,
        title: Text(text),
      ),
    );
  }
}
