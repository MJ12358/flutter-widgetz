part of flutter_widgetz;

class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder({
    Key? key,
    required this.text,
    this.asset,
  }) : super(key: key);

  final String text;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          if (asset != null) ...<Widget>[
            Image.asset(
              asset!,
              height: MediaQuery.of(context).size.height / 4,
            ),
            const SizedBox(height: 20.0),
          ] else
            const SizedBox(),
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
}
