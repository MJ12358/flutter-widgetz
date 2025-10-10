part of flutter_widgetz;

/// {@template flutter_widgetz.GroupedSliverList}
/// A groupable list of widgets, similar to [SliverList],
/// except that the items can be sectioned into groups.
///
///![GroupedSliverList](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/grouped_list.png)
/// {@endtemplate}
class GroupedSliverList<T, E> extends StatelessWidget {
  /// {@macro flutter_widgetz.GroupedSliverList}
  const GroupedSliverList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.groupBy,
    this.groupHeaderBuilder,
    this.groupSeparatorBuilder,
    this.separatorBuilder,
  });

  /// The items of which the [itemBuilder] produces.
  final List<T> items;

  /// Called to build the [items].
  final GroupedWidgetBuilder<T> itemBuilder;

  /// Defines which [items] are grouped together.
  final E Function(T item) groupBy;

  /// Called to build group headers.
  final Widget Function(E value)? groupHeaderBuilder;

  /// Called to build group separators.
  final GroupedWidgetBuilder<T>? groupSeparatorBuilder;

  /// Called to build list separators.
  final GroupedWidgetBuilder<T>? separatorBuilder;

  List<_ListViewItem<T, E>> _buildListViewItems() {
    if (items.isEmpty) {
      return <_ListViewItem<T, E>>[];
    }

    // Group items
    final Map<E, List<T>> grouping = <E, List<T>>{};
    for (final T item in items) {
      final E key = groupBy(item);
      (grouping[key] ??= <T>[]).add(item);
    }

    // Build flat list of all items
    final List<_ListViewItem<T, E>> listItems = <_ListViewItem<T, E>>[];
    final List<MapEntry<E, List<T>>> groups = grouping.entries.toList();

    for (int i = 0; i < groups.length; i++) {
      final MapEntry<E, List<T>> group = groups[i];

      // Add group header
      listItems.add(_ListViewItem<T, E>.header(group.key));

      // Add group items with separators
      for (int j = 0; j < group.value.length; j++) {
        listItems.add(_ListViewItem<T, E>.item(group.value[j]));

        // Add item separator if not last item and separator exists
        if (j < group.value.length - 1 && separatorBuilder != null) {
          listItems.add(_ListViewItem<T, E>.itemSeparator(group.value[j]));
        }
      }

      // Add group separator if not last group and separator exists
      if (i < groups.length - 1 && groupSeparatorBuilder != null) {
        listItems.add(_ListViewItem<T, E>.groupSeparator(group.value.last));
      }
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final List<_ListViewItem<T, E>> listItems = _buildListViewItems();

    return SliverList.builder(
      itemCount: listItems.length,
      itemBuilder: (BuildContext context, int index) {
        final _ListViewItem<T, E> item = listItems[index];

        return item.map(
          header: (_HeaderItem<T, E> header) =>
              groupHeaderBuilder?.call(header.value) ?? const SizedBox.shrink(),
          item: (_ListItem<T, E> item) => itemBuilder(context, item.value),
          itemSeparator: (_ItemSeparator<T, E> separator) =>
              separatorBuilder?.call(context, separator.value) ??
              const SizedBox.shrink(),
          groupSeparator: (_GroupSeparator<T, E> separator) =>
              groupSeparatorBuilder?.call(context, separator.value) ??
              const SizedBox.shrink(),
        );
      },
    );
  }
}
