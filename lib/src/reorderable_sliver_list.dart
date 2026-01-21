part of flutter_widgetz;

/// {@template flutter_widgetz.CustomSLiverReorderableList}
/// Wraps [SliverReorderableList] to allow a separator.
///
///![CustomSliverReorderableList](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/list_view.png)
/// {@endtemplate}
class CustomSliverReorderableList extends StatelessWidget {
  /// Used to build the items.
  final IndexedWidgetBuilder itemBuilder;

  /// The item count.
  final int itemCount;

  /// The function called on reorder.
  final ReorderCallback onReorder;

  /// The padding of this list.
  final EdgeInsets padding;

  static const EdgeInsets _defaultPadding = EdgeInsets.zero;

  /// Builder uses [itemBuilder] to build widgets.
  ///
  /// {@macro flutter_widgetz.CustomSLiverReorderableList}
  const CustomSliverReorderableList.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onReorder,
    this.padding = _defaultPadding,
  });

  /// List uses [children] to build widgets.
  ///
  /// {@macro flutter_widgetz.CustomSLiverReorderableList}
  CustomSliverReorderableList.list({
    super.key,
    required List<Widget> children,
    required this.onReorder,
    this.padding = _defaultPadding,
  })  : itemCount = children.length,
        itemBuilder = ((_, int index) {
          return children[index];
        });

  /// Separated inserts a separator between widgets.
  ///
  /// {@macro flutter_widgetz.CustomSLiverReorderableList}
  CustomSliverReorderableList.separated({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required ReorderCallback onReorder,
    this.padding = _defaultPadding,
  })  : itemCount = _computeActualChildCount(itemCount),
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
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          if (oldIndex.isOdd) {
            // separator - should never happen
            return;
          }
          if ((oldIndex - newIndex).abs() == 1) {
            // moved behind the top/bottom separator
            return;
          }
          newIndex = oldIndex > newIndex && newIndex.isOdd
              ? (newIndex + 1) ~/ 2
              : newIndex ~/ 2;
          oldIndex = oldIndex ~/ 2;
          onReorder.call(oldIndex, newIndex);
        });

  // Helper method to compute the actual child count
  // for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  /// From:
  /// https://api.flutter.dev/flutter/material/ReorderableListView-class.html#material.ReorderableListView.1
  Widget _itemBuilder(BuildContext context, int index) {
    final Widget item = itemBuilder(context, index);
    assert(
      item.key != null,
      'Every item of SliverReorderableList must have a key.',
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
        onReorder: onReorder,
      ),
    );
  }
}

/// From:
/// https://api.flutter.dev/flutter/material/ReorderableListView-class.html#material.ReorderableListView.1
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
