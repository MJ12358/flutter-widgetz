part of flutter_widgetz;

/// {@template flutter_widgetz.FeedbackBar}
/// A feedback widget.
/// {@endtemplate}
class FeedbackBar extends StatelessWidget {
  /// {@macro flutter_widgetz.FeedbackBar}
  const FeedbackBar({
    super.key,
    required this.assets,
    required this.onChanged,
    this.footer,
    this.header,
    this.headerText,
    this.rtl = _defaultRtl,
    this.spacing = _defaultSpacing,
  }) : color = null;

  /// The assets displayed.
  final List<String> assets;

  /// The color of the assets.
  final Color? color;

  /// An optional footer widget.
  final Widget? footer;

  /// An optional header widget.
  final Widget? header;

  /// Optional text for the header.
  final String? headerText;

  /// A callback called when feedback is pressed.
  final ValueChanged<int> onChanged;

  /// Determines if the assets could be right to left.
  final bool rtl;

  /// The spacing between the assets.
  final double spacing;

  static const bool _defaultRtl = false;
  static const double _defaultSpacing = 20.0;

  /// {@macro flutter_widgetz.FeedbackBar}
  ///
  /// Outlined uses an outlined icon.
  FeedbackBar.outlined({
    super.key,
    required this.onChanged,
    this.color,
    this.footer,
    this.header,
    this.headerText,
    this.rtl = _defaultRtl,
    this.spacing = _defaultSpacing,
  }) : assets = <String>[
          _kVeryBadEmojiOutlined,
          _kBadEmojiOutlined,
          _kOkayEmojiOutlined,
          _kGoodEmojiOutlined,
          _kVeryGoodEmojiOutlined,
        ];

  /// {@macro flutter_widgetz.FeedbackBar}
  ///
  /// Filled uses a filled icon.
  FeedbackBar.filled({
    super.key,
    required this.onChanged,
    this.footer,
    this.header,
    this.headerText,
    this.rtl = _defaultRtl,
    this.spacing = _defaultSpacing,
  })  : assets = <String>[
          _kVeryBadEmojiFilled,
          _kBadEmojiFilled,
          _kOkayEmojiFilled,
          _kGoodEmojiFilled,
          _kVeryGoodEmojiFilled,
        ],
        color = null;

  Widget? get _header {
    if (header != null) {
      return header!;
    }
    if (headerText != null) {
      return Text(headerText!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.titleMedium!,
      child: SpacedColumn(
        spacing: 8.0,
        children: <Widget>[
          if (_header != null) _header!,
          SpacedRow(
            spacing: spacing,
            children: _buildChildren(),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }

  List<Widget> _buildChildren() {
    final List<String> images = rtl ? assets.reversed.toList() : assets;

    return images.asMap().entries.map((MapEntry<int, String> entry) {
      return _Image(
        path: entry.value,
        color: color,
        onTap: () => onChanged.call(entry.key),
      );
    }).toList();
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.path,
    this.color,
    this.onTap,
  });

  final String path;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // this is set to the size of the asset
      borderRadius: BorderRadius.circular(128),
      child: Image.asset(
        path,
        package: 'flutter_widgetz',
        color: color,
      ),
    );
  }
}
