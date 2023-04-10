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
    this.networkImage,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  /// The text of this placeholder.
  final String text;

  /// The asset image for this placeholder.
  final String? assetImage;

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
          _getImage(context),
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

  Widget _getImage(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 4;

    if (hasAssetImage) {
      return Image.asset(
        assetImage!,
        height: height,
      );
    } else if (hasNetworkImage) {
      return Image.network(
        networkImage!,
        height: height,
      );
    } else {
      return const SizedBox();
    }
  }
}
