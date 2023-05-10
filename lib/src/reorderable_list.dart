part of flutter_widgetz;

/// {@template flutter_widgetz.CustomReorderableListView}
/// Wraps [ReorderableListView] to allow a separator.
///
/// Inspired by: https://github.com/flutter/flutter/issues/76706
/// {@endtemplate}
class CustomReorderableListView extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomReorderableListView}
  const CustomReorderableListView._({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onReorder,
    Clip? clipBehavior,
  })  : clipBehavior = clipBehavior ?? Clip.hardEdge,
        super(key: key);

  /// The number of items in the list.
  final int itemCount;

  /// Called, as needed, to build list item widgets.
  final IndexedWidgetBuilder itemBuilder;

  /// A callback used by the list to report that a list item has been dragged.
  final ReorderCallback onReorder;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// {@macro flutter_widgetz.CustomReorderableListView}
  factory CustomReorderableListView.separated({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required ReorderCallback onReorder,
    Clip? clipBehavior,
  }) {
    return CustomReorderableListView._(
      clipBehavior: clipBehavior,
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
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      clipBehavior: clipBehavior,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      onReorder: onReorder,
    );
  }

  // Helper method to compute the actual child count
  // for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
