part of '../flutter_widgetz.dart';

/// {@template flutter_widgetz.CustomReorderableSliverList}
/// Wraps [SliverReorderableList] and allows for more control and concise usage.
///
///![CustomReorderableSliverList](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/list_view.png)
/// {@endtemplate}
class CustomReorderableSliverList extends StatelessWidget {
  /// Used to build the items.
  final IndexedWidgetBuilder itemBuilder;

  /// The item count.
  final int itemCount;

  /// The function called on reorder.
  final ReorderCallback onReorder;

  /// The padding of this list.
  final EdgeInsets padding;

  static const EdgeInsets _defaultPadding = EdgeInsets.zero;

  /// Separated inserts a separator between widgets.
  ///
  /// {@macro flutter_widgetz.CustomReorderableSliverList}
  CustomReorderableSliverList.separated({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required ReorderCallback onReorder,
    this.padding = _defaultPadding,
  }) : itemCount = _computeSeparatorChildCount(itemCount),
       itemBuilder = ((BuildContext context, int index) {
         if (index.isOdd) {
           final Widget separator = separatorBuilder.call(context, index);
           if (separator.key == null) {
             return KeyedSubtree(
               key: ValueKey<String>('ReorderableSliverSeparator${index}Key'),
               child: IgnorePointer(child: separator),
             );
           }
           return separator;
         }
         return itemBuilder.call(context, index ~/ 2);
       }),
       onReorder = ((int oldIndex, int newIndex) {
         return _separatorAwareReorderHandler(
           onReorder,
         )?.call(oldIndex, newIndex);
       });

  /// From:
  /// reorderable_list.dart `_ReorderableListViewState._itemBuilder`
  Widget _itemBuilder(BuildContext context, int index) {
    final Widget item = itemBuilder(context, index);
    assert(
      item.key != null,
      'Every item of ReorderableSliverList must have a key.',
    );

    final Key itemGlobalKey = _GlobalKey(item.key!, this);

    switch (Theme.of(context).platform) {
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return Stack(
          key: itemGlobalKey,
          children: <Widget>[
            item,
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 0,
              bottom: 0,
              end: 8,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
              ),
            ),
          ],
        );

      case TargetPlatform.iOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return ReorderableDelayedDragStartListener(
          key: itemGlobalKey,
          index: index,
          child: item,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverReorderableList(
        itemBuilder: _itemBuilder,
        itemCount: itemCount,
        onReorderItem: onReorder,
      ),
    );
  }
}

/// From:
/// reorderable_list.dart `ReorderableListViewChildGlobalKey`
class _GlobalKey extends GlobalObjectKey {
  const _GlobalKey(this.subKey, this.state) : super(subKey);

  final Key subKey;
  final Widget state;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _GlobalKey &&
        other.subKey == subKey &&
        other.state == state;
  }

  @override
  int get hashCode => Object.hash(subKey, state);
}
