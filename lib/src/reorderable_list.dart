part of flutter_widgetz;

/// {@template flutter_widgetz.CustomReorderableListView}
/// Wraps [ReorderableListView] to allow a separator.
///
/// Inspired by: https://github.com/flutter/flutter/issues/76706
/// {@endtemplate}
class CustomReorderableListView extends ReorderableListView {
  /// {@macro flutter_widgetz.CustomReorderableListView}
  CustomReorderableListView.separated({
    super.key,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required ReorderCallback onReorder,
    super.clipBehavior,
    super.header,
    super.proxyDecorator,
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
}
