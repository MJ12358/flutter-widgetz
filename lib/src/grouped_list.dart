part of flutter_widgetz;

typedef GroupedWidgetBuilder<T> = Widget Function(BuildContext, T);
typedef GroupHeaderBuilder<T, E> = Widget Function(BuildContext, E, List<T>);

/// {@template flutter_widgetz.GroupedListView}
/// A groupable list of widgets, similar to [ListView],
/// except that the items can be sectioned into groups.
///
///![GroupedListView](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/grouped_list.png)
/// {@endtemplate}
class GroupedListView<T, E> extends StatelessWidget {
  /// {@macro flutter_widgetz.GroupedListView}
  const GroupedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.groupBy,
    this.groupHeaderBuilder,
    this.groupSeparatorBuilder,
    this.separatorBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.physics,
    this.shrinkWrap = false,
  });

  /// The items of which the [itemBuilder] produces.
  final List<T> items;

  /// Called to build the [items].
  final GroupedWidgetBuilder<T> itemBuilder;

  /// Defines which [items] are grouped together.
  final E Function(T item) groupBy;

  /// Called to build group headers.
  final GroupHeaderBuilder<T, E>? groupHeaderBuilder;

  /// Called to build group separators.
  final GroupedWidgetBuilder<T>? groupSeparatorBuilder;

  /// Called to build list separators.
  final GroupedWidgetBuilder<T>? separatorBuilder;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view should be
  /// determined by the contents being viewed.
  final bool shrinkWrap;

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
      final List<T> groupItems = group.value;

      // Add group header with access to the items
      listItems.add(_ListViewItem<T, E>.header(group.key, groupItems));

      // Add group items with separators
      for (int j = 0; j < groupItems.length; j++) {
        listItems.add(_ListViewItem<T, E>.item(groupItems[j]));

        // Add item separator if not last item and separator exists
        if (j < groupItems.length - 1 && separatorBuilder != null) {
          listItems.add(_ListViewItem<T, E>.itemSeparator(groupItems[j]));
        }
      }

      // Add group separator if not last group and separator exists
      if (i < groups.length - 1 && groupSeparatorBuilder != null) {
        listItems.add(_ListViewItem<T, E>.groupSeparator(groupItems.last));
      }
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final List<_ListViewItem<T, E>> listItems = _buildListViewItems();

    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (BuildContext context, int index) {
        final _ListViewItem<T, E> item = listItems[index];

        return item.map(
          header: (_HeaderItem<T, E> header) =>
              groupHeaderBuilder?.call(
                context,
                header.groupKey,
                header.groupItems,
              ) ??
              const SizedBox.shrink(),
          item: (_ListItem<T, E> item) => itemBuilder(context, item.value),
          itemSeparator: (_ItemSeparator<T, E> separator) =>
              separatorBuilder?.call(context, separator.value) ??
              const SizedBox.shrink(),
          groupSeparator: (_GroupSeparator<T, E> separator) =>
              groupSeparatorBuilder?.call(context, separator.value) ??
              const SizedBox.shrink(),
        );
      },
      clipBehavior: clipBehavior,
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }
}

// Helper sealed class for type-safe list items
sealed class _ListViewItem<T, E> {
  const _ListViewItem();

  const factory _ListViewItem.header(E groupKey, List<T> groupItems) =
      _HeaderItem<T, E>._;
  const factory _ListViewItem.item(T value) = _ListItem<T, E>._;
  const factory _ListViewItem.itemSeparator(T value) = _ItemSeparator<T, E>._;
  const factory _ListViewItem.groupSeparator(T value) = _GroupSeparator<T, E>._;

  R map<R>({
    required R Function(_HeaderItem<T, E>) header,
    required R Function(_ListItem<T, E>) item,
    required R Function(_ItemSeparator<T, E>) itemSeparator,
    required R Function(_GroupSeparator<T, E>) groupSeparator,
  });
}

class _HeaderItem<T, E> extends _ListViewItem<T, E> {
  final E groupKey;
  final List<T> groupItems;

  const _HeaderItem._(this.groupKey, this.groupItems);

  @override
  R map<R>({
    required R Function(_HeaderItem<T, E>) header,
    required R Function(_ListItem<T, E>) item,
    required R Function(_ItemSeparator<T, E>) itemSeparator,
    required R Function(_GroupSeparator<T, E>) groupSeparator,
  }) =>
      header(this);
}

class _ListItem<T, E> extends _ListViewItem<T, E> {
  final T value;

  const _ListItem._(this.value);

  @override
  R map<R>({
    required R Function(_HeaderItem<T, E>) header,
    required R Function(_ListItem<T, E>) item,
    required R Function(_ItemSeparator<T, E>) itemSeparator,
    required R Function(_GroupSeparator<T, E>) groupSeparator,
  }) =>
      item(this);
}

class _ItemSeparator<T, E> extends _ListViewItem<T, E> {
  final T value;

  const _ItemSeparator._(this.value);

  @override
  R map<R>({
    required R Function(_HeaderItem<T, E>) header,
    required R Function(_ListItem<T, E>) item,
    required R Function(_ItemSeparator<T, E>) itemSeparator,
    required R Function(_GroupSeparator<T, E>) groupSeparator,
  }) =>
      itemSeparator(this);
}

class _GroupSeparator<T, E> extends _ListViewItem<T, E> {
  final T value;

  const _GroupSeparator._(this.value);

  @override
  R map<R>({
    required R Function(_HeaderItem<T, E>) header,
    required R Function(_ListItem<T, E>) item,
    required R Function(_ItemSeparator<T, E>) itemSeparator,
    required R Function(_GroupSeparator<T, E>) groupSeparator,
  }) =>
      groupSeparator(this);
}
