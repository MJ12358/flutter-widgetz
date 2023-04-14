part of flutter_widgetz;

/// {@template flutter_widgetz.CustomPlaceholder}
/// A placeholder that displays an image above some text.
/// {@endtemplate}
class CustomPlaceholder extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomPlaceholder}
  const CustomPlaceholder({
    Key? key,
    required this.text,
    this.assetImage,
    this.child,
    this.networkImage,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  /// The text of this placeholder.
  final String text;

  /// The asset image for this placeholder.
  final String? assetImage;

  /// A widget to be used above the text.
  final Widget? child;

  /// The network image for this placeholder.
  final String? networkImage;

  /// How the children should be placed along the main axis in a flex layout.
  final MainAxisAlignment mainAxisAlignment;

  bool get hasAssetImage => assetImage != null;
  bool get hasNetworkImage => networkImage != null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          _getChild(context),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getChild(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 4;

    if (child != null) {
      return SizedBox(
        height: height,
        child: child,
      );
    }

    if (hasAssetImage) {
      return Image.asset(
        assetImage!,
        height: height,
      );
    }

    if (hasNetworkImage) {
      return Image.network(
        networkImage!,
        height: height,
      );
    }

    return const SizedBox();
  }
}
