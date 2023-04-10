part of flutter_widgetz;

/// {@template flutter_widgetz.CustomElevatedButton}
/// An [ElevatedButton] that utilizes the
/// full width of its container.
/// {@endtemplate}
class CustomElevatedButton extends StatelessWidget {
  /// {@macro flutter_widgetz.CustomElevatedButton}
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                // TODO: this should be black OR white based on primary color
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
        ),
      ),
    );
  }
}
