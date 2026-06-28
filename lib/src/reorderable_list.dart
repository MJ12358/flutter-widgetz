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
         onReorderItem: (int oldIndex, int newIndex) {
           int oi = oldIndex;
           int ni = newIndex;
           if (oi < ni) {
             ni -= 1;
           }
           if (oi.isOdd) {
             // separator - should never happen
             return;
           }
           if ((oi - ni).abs() == 1) {
             // moved behind the top/bottom separator
             return;
           }
           ni = oi > ni && ni.isOdd ? (ni + 1) ~/ 2 : ni ~/ 2;
           oi = oi ~/ 2;
           onReorder.call(oi, ni);
         },
       );

  // Helper method to compute the actual child count
  // for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
