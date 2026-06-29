part of '../flutter_widgetz.dart';

/// {@template flutter_widgetz.CustomReorderableListView}
/// Wraps [ReorderableListView] to allow a separator.
///
/// Inspired by: https://github.com/flutter/flutter/issues/76706
///
///![CustomReorderableListView](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/list_view.png)
/// {@endtemplate}
class CustomReorderableListView extends ReorderableListView {
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
         itemCount: _computeSeparatorChildCount(itemCount),
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
         onReorderItem: _separatorAwareReorderHandler(onReorder),
       );
}

/// Helper method to compute the actual child
/// count for the separated constructor.
int _computeSeparatorChildCount(int itemCount) {
  return math.max(0, itemCount * 2 - 1);
}

/// Helper method to convert visual indices to logical indices.
void Function(int, int)? _separatorAwareReorderHandler(
  ReorderCallback onReorder,
) {
  return (int oldIndex, int newIndex) {
    int oi = oldIndex;
    int ni = newIndex;
    // If dragging down, adjust for removal (visual-level adjustment)
    if (oi < ni) {
      ni -= 1;
    }
    // Skip if it's a separator (visual-level check)
    if (oi.isOdd) {
      return;
    }
    // Convert visual indices to logical indices
    oi = oi ~/ 2;
    // Convert newIndex from visual to logical
    if (ni.isOdd) {
      // Dropping before a separator means we're
      // dropping after the previous item
      ni = (ni - 1) ~/ 2 + 1;
    } else {
      // Dropping on an item position
      ni = ni ~/ 2;
    }
    onReorder.call(oi, ni);
  };
}
