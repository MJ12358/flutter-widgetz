part of flutter_widgetz;

/// {@template flutter_widgetz.GroupedSliverList}
/// A groupable list of widgets, similar to [SliverList],
/// except that the items can be sectioned into groups.
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
        _SubSliver<T>(
          items: group.value,
          itemBuilder: itemBuilder,
          separatorBuilder: separatorBuilder,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: _grouping.length,
      itemBuilder: _itemBuilder,
      separatorBuilder: _separatorBuilder,
    );
  }
}

class _SubSliver<T> extends StatelessWidget {
  const _SubSliver({
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
