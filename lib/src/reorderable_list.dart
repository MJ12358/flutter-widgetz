part of flutter_widgetz;

/// {@template flutter_widgetz.CustomReorderableListView}
/// Wraps [ReorderableListView] to allow a separator and fix
/// indexing issue in the original Flutter widget.
///
/// https://github.com/flutter/flutter/issues/24786
///
/// Inspired by: https://github.com/flutter/flutter/issues/76706
///
///![CustomReorderableListView](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/list_view.png)
/// {@endtemplate}
class CustomReorderableListView extends ReorderableListView {
  /// {@macro flutter_widgetz.CustomReorderableListView}
  CustomReorderableListView({
    super.key,
    required super.children,
    required ReorderCallback onReorder,
    super.clipBehavior,
    super.footer,
    super.header,
    super.padding,
    super.physics,
    super.proxyDecorator,
    super.shrinkWrap,
  }) : super(
          onReorder: (int oldIndex, int newIndex) {
            _defaultReorderCallback(oldIndex, newIndex, onReorder);
          },
        );

  /// Builder uses [ReorderableListView.builder].
  ///
  /// {@macro flutter_widgetz.CustomReorderableListView}
  CustomReorderableListView.builder({
    super.key,
    required super.itemCount,
    required super.itemBuilder,
    required ReorderCallback onReorder,
    super.clipBehavior,
    super.footer,
    super.header,
    super.padding,
    super.physics,
    super.proxyDecorator,
    super.shrinkWrap,
  }) : super.builder(
          onReorder: (int oldIndex, int newIndex) {
            _defaultReorderCallback(oldIndex, newIndex, onReorder);
          },
        );

  /// Separated uses [ReorderableListView.builder] with separators.
  ///
  /// {@macro flutter_widgetz.CustomReorderableListView}
  CustomReorderableListView.separated({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required ReorderCallback onReorder,
    super.clipBehavior,
    super.footer,
    super.header,
    super.padding,
    super.physics,
    super.proxyDecorator,
    super.shrinkWrap,
  }) : super.builder(
          itemCount: _computeActualChildCount(itemCount),
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) {
              final Widget separator = separatorBuilder.call(context, index);
              if (separator.key == null) {
                return KeyedSubtree(
                  key: ValueKey<String>('ReorderableSeparator${index}Key'),
                  child: IgnorePointer(child: separator),
                );
              }
              return separator;
            }
            return itemBuilder.call(context, index ~/ 2);
          },
          onReorder: (int oldIndex, int newIndex) {
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
          },
        );

  // Helper method to compute the actual child count
  // for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  // Helper method to adjust indices for reordering.
  static void _defaultReorderCallback(
    int oldIndex,
    int newIndex,
    ReorderCallback onReorder,
  ) {
    int adjustedIndex = newIndex;
    if (oldIndex < newIndex) {
      adjustedIndex -= 1;
    }
    onReorder(oldIndex, adjustedIndex);
  }
}
