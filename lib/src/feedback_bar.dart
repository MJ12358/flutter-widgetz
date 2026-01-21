part of flutter_widgetz;

/// {@template flutter_widgetz.FeedbackBar}
/// A feedback widget.
///
///![FeedbackBar](https://raw.githubusercontent.com/MJ12358/flutter-widgetz/main/screenshots/feedback_bar.png)
/// {@endtemplate}
class FeedbackBar extends StatelessWidget {
  /// {@macro flutter_widgetz.FeedbackBar}
  const FeedbackBar({
    super.key,
    required this.items,
    required this.onChanged,
    this.footer,
    this.header,
    this.orientation = _defaultOrientation,
    this.rtl = _defaultRtl,
    this.shape = _defaultShape,
    this.spacing = _defaultSpacing,
  });

  /// The content displayed.
  final List<Widget> items;

  /// An optional footer widget.
  final Widget? footer;

  /// An optional header widget.
  final Widget? header;

  /// A callback called when feedback is pressed.
  final ValueChanged<int> onChanged;

  /// The orientation of the [items].
  final Orientation orientation;

  /// Determines if the [items] should be right to left.
  final bool rtl;

  /// The shape of the item's [InkWell].
  final BoxShape shape;

  /// The spacing between the assets.
  final double spacing;

  static const Orientation _defaultOrientation = Orientation.landscape;
  static const bool _defaultRtl = false;
  static const BoxShape _defaultShape = BoxShape.rectangle;
  static const double _defaultSpacing = 20.0;

  /// Outlined uses an outlined icon.
  ///
  /// {@macro flutter_widgetz.FeedbackBar}
  FeedbackBar.outlined({
    super.key,
    required this.onChanged,
    Color? color,
    this.footer,
    this.header,
    this.orientation = _defaultOrientation,
    this.rtl = _defaultRtl,
    this.spacing = _defaultSpacing,
  })  : shape = BoxShape.circle,
        items = <Widget>[
          _Image(asset: _kVeryBadEmojiOutlined, color: color),
          _Image(asset: _kBadEmojiOutlined, color: color),
          _Image(asset: _kOkayEmojiOutlined, color: color),
          _Image(asset: _kGoodEmojiOutlined, color: color),
          _Image(asset: _kVeryGoodEmojiOutlined, color: color),
        ];

  /// Filled uses a filled icon.
  ///
  /// {@macro flutter_widgetz.FeedbackBar}
  FeedbackBar.filled({
    super.key,
    required this.onChanged,
    Color? color,
    this.footer,
    this.header,
    this.orientation = _defaultOrientation,
    this.rtl = _defaultRtl,
    this.spacing = _defaultSpacing,
  })  : shape = BoxShape.circle,
        items = <Widget>[
          _Image(asset: _kVeryBadEmojiFilled, color: color),
          _Image(asset: _kBadEmojiFilled, color: color),
          _Image(asset: _kOkayEmojiFilled, color: color),
          _Image(asset: _kGoodEmojiFilled, color: color),
          _Image(asset: _kVeryGoodEmojiFilled, color: color),
        ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle.merge(
      style: theme.textTheme.titleMedium,
      child: SpacedColumn(
        spacer: const SizedBox(height: 8.0),
        children: <Widget>[
          if (header != null) header!,
          if (orientation == Orientation.landscape)
            SpacedRow(
              spacer: SizedBox(width: spacing),
              children: _buildChildren(),
            )
          else
            SpacedColumn(
              spacer: SizedBox(height: spacing),
              children: _buildChildren(),
            ),
          if (footer != null) footer!,
        ],
      ),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> images = rtl ? items.reversed.toList() : items;

    return images.asMap().entries.map((MapEntry<int, Widget> entry) {
      return _FeedbackItem(
        item: entry.value,
        onTap: () => onChanged.call(entry.key),
        shape: shape,
      );
    }).toList();
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.asset,
    this.color,
  });

  final String asset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      package: _kPackage,
      color: color,
    );
  }
}

class _FeedbackItem extends StatelessWidget {
  const _FeedbackItem({
    required this.item,
    required this.onTap,
    required this.shape,
  });

  final Widget item;
  final VoidCallback onTap;
  final BoxShape shape;

  ShapeBorder get _border {
    switch (shape) {
      case BoxShape.circle:
        return const CircleBorder();
      case BoxShape.rectangle:
        return const RoundedRectangleBorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: _border,
      child: item,
    );
  }
}
