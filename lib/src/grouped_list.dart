part of flutter_widgetz;

typedef GroupedWidgetBuilder<T> = Widget Function(BuildContext, T);

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
  final Widget Function(E value)? groupHeaderBuilder;

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

  Map<E, List<T>> get _grouping {
    final Map<E, List<T>> map = <E, List<T>>{};
    for (final T item in items) {
      (map[groupBy(item)] ??= <T>[]).add(item);
    }
    return map;
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    if (groupSeparatorBuilder == null) {
      return const SizedBox.shrink();
    }
    final MapEntry<E, List<T>> group = _grouping.entries.elementAt(index);
    return groupSeparatorBuilder!.call(context, group.value[index]);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final MapEntry<E, List<T>> group = _grouping.entries.elementAt(index);
    return Column(
      children: <Widget>[
        groupHeaderBuilder?.call(group.key) ?? const SizedBox.shrink(),
        _SubList<T>(
          items: group.value,
          itemBuilder: itemBuilder,
          separatorBuilder: separatorBuilder,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _grouping.length,
      itemBuilder: _itemBuilder,
      separatorBuilder: _separatorBuilder,
      clipBehavior: clipBehavior,
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }
}

class _SubList<T> extends StatelessWidget {
  const _SubList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  final List<T> items;
  final GroupedWidgetBuilder<T> itemBuilder;
  final GroupedWidgetBuilder<T>? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final T item = items[index];
        return itemBuilder.call(context, item);
      },
      separatorBuilder: (BuildContext context, int index) {
        if (separatorBuilder == null) {
          return const SizedBox.shrink();
        }
        final T item = items[index];
        return separatorBuilder!.call(context, item);
      },
    );
  }
}
